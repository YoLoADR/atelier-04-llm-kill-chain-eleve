#!/usr/bin/env bash
# ---------------------------------------------------------------------------
# check_atelier_ready.sh — « Pré-vol » d'un atelier cyberdéfense
#
# Vérifie qu'un atelier est jouable AVANT de commencer :
#   (a) les outils nécessaires sont installés sur ta machine,
#   (b) le lab (VPS Contabo 109.199.97.174) répond,
#   (c) le service-cible de CET atelier est en ligne.
#
# Usage :  bash scripts/check_atelier_ready.sh 01
#          bash scripts/check_atelier_ready.sh 08
#
# Sortie : code 0 si tout est vert, 1 sinon (avec un message clair en français).
# Cible unique autorisée : 109.199.97.174 (le lab de Yohann). Rien d'autre.
# ---------------------------------------------------------------------------
set -uo pipefail

NN="${1:-}"
VPS_IP="109.199.97.174"

# Couleurs (désactivées si pas un terminal)
if [ -t 1 ]; then G=$'\e[32m'; R=$'\e[31m'; Y=$'\e[33m'; B=$'\e[1m'; X=$'\e[0m'; else G=; R=; Y=; B=; X=; fi
ok()   { echo "  ${G}✓${X} $1"; }
ko()   { echo "  ${R}✗${X} $1"; FAIL=1; }
warn() { echo "  ${Y}!${X} $1"; }

if [ -z "$NN" ]; then
  echo "Usage : bash scripts/check_atelier_ready.sh <NN>   (ex : 01, 08)"
  exit 2
fi
NN=$(printf "%02d" "$((10#$NN))" 2>/dev/null || echo "$NN")
FAIL=0

# --- Manifeste : pour chaque atelier, l'URL-cible à tester + les outils requis.
# (URL = le service « victime » principal ; outils = ce que la manip rouge utilise)
case "$NN" in
  00) URL="";                                                          TOOLS="curl ssh git";        NOTE="Pré-vol global : rien à tester côté lab." ;;
  01) URL="http://${VPS_IP}:3000/login";                               TOOLS="curl nmap hydra ssh"; NOTE="" ;;
  02) URL="https://soluvia.109-199-97-174.sslip.io";                   TOOLS="curl";                NOTE="Atelier MOBILE : prépare aussi le téléphone secondaire (Xiaomi)." ;;
  03) URL="https://portail-rh-corp.109-199-97-174.sslip.io";           TOOLS="curl python3";        NOTE="" ;;
  04) URL="https://chatbot-rh.109-199-97-174.sslip.io/health";         TOOLS="curl python3";        NOTE="" ;;
  05) URL="http://${VPS_IP}/payloads/";                                TOOLS="curl ssh";            NOTE="" ;;
  06) URL="https://assistant-ia.109-199-97-174.sslip.io/health";       TOOLS="curl";                NOTE="" ;;
  07) URL="https://connexion-soluvia.109-199-97-174.sslip.io/login";   TOOLS="curl";                NOTE="" ;;
  08) URL="https://collecte-soluvia.109-199-97-174.sslip.io/loot";     TOOLS="curl python3";        NOTE="" ;;
  09) URL="https://soluvia-productivity.109-199-97-174.sslip.io/";     TOOLS="curl";                NOTE="Dépend de l'activation OAuth GCP (voir formateur)." ;;
  10) URL="https://recharge-soluvia.109-199-97-174.sslip.io/";         TOOLS="curl";                NOTE="" ;;
  11) URL="https://collecte-ransom.109-199-97-174.sslip.io";           TOOLS="curl python3";        NOTE="" ;;
  *)  echo "${R}Atelier inconnu : $NN${X} (attendu 00 à 11)"; exit 2 ;;
esac

echo "${B}== Pré-vol atelier $NN ==${X}"

# 1) Outils locaux
# Hint d'installation selon l'OS : apt sur la VM Linux des élèves, brew sur le Mac du formateur.
if command -v brew >/dev/null 2>&1; then INSTALL="brew install"; else INSTALL="sudo apt install -y"; fi
echo "${B}1. Outils sur ta machine${X}"
for t in $TOOLS; do
  if command -v "$t" >/dev/null 2>&1; then ok "$t installé"
  else ko "$t manquant  →  installe-le avec :  $INSTALL $t"; fi
done

# 2) Le lab répond-il ? (on teste juste que la machine de Yohann est joignable)
echo "${B}2. Le lab (VPS $VPS_IP) répond${X}"
if curl -s -m 6 -o /dev/null "http://${VPS_IP}" 2>/dev/null || nc -z -w4 "$VPS_IP" 22 2>/dev/null; then
  ok "Le serveur du lab est joignable"
else
  ko "Impossible de joindre $VPS_IP — vérifie ta connexion Internet, ou préviens Yohann (le lab est peut-être éteint)."
fi

# 3) Le service de CET atelier est-il en ligne ?
echo "${B}3. Le service de l'atelier $NN${X}"
if [ -z "$URL" ]; then
  ok "$NOTE"
else
  code=$(curl -s -k -m 8 -o /dev/null -w "%{http_code}" "$URL" 2>/dev/null)
  if [[ "$code" =~ ^[1-4][0-9][0-9]$ ]]; then
    ok "Service en ligne ($URL → HTTP $code)"
  else
    ko "Le service ne répond pas ($URL → $code) — préviens Yohann pour qu'il le démarre."
  fi
  [ -n "$NOTE" ] && warn "$NOTE"
fi

echo
if [ "$FAIL" -eq 0 ]; then
  echo "${G}${B}✓ Tout est prêt pour l'atelier $NN. Bonne chasse 🕵️${X}"
  exit 0
else
  echo "${R}${B}✗ Atelier $NN pas encore prêt — corrige les ✗ ci-dessus.${X}"
  exit 1
fi
