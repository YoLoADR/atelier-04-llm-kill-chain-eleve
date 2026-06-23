#!/usr/bin/env bash
# Checkpoint final (atelier 04) — QCM auto-corrigé sur toute la kill chain LLM.
# Lance :  bash checkpoints/check_final.sh
set -uo pipefail
if [ -t 1 ]; then G=$'\e[32m'; R=$'\e[31m'; B=$'\e[1m'; X=$'\e[0m'; else G=; R=; B=; X=; fi
score=0; total=5
ask() { echo "${B}$1${X}"; read -r -p "Ta réponse (a/b/c) : " rep
  rep=$(printf '%s' "$rep" | tr '[:upper:]' '[:lower:]' | tr -d ' ')
  if [ "$rep" = "$2" ]; then echo "${G}✓${X} $3"; score=$((score+1)); else echo "${R}✗${X} $3"; fi; echo; }

echo "== Checkpoint final — atelier 04 =="; echo
ask "1) Pour exfiltrer les données RH, l'attaquant a-t-il eu besoin d'un accès au serveur ou d'un mot de passe ?
  a) oui  b) non, juste une question bien formulée  c) seulement avec un VPN" "b" "Zéro accès technique : il a posé une question, et le document poison a fait le reste."
ask "2) Quelle est la différence entre injection DIRECTE et INDIRECTE ?
  a) aucune  b) directe = l'instruction est dans ta question ; indirecte = elle est cachée dans un document lu par le LLM  c) indirecte = via le réseau" "b" "L'indirecte est la plus dangereuse : la victime pose une question normale, l'instruction vient des données."
ask "3) Quel garde-fou attrape une réponse contenant « DONNÉES EXPORTÉES : » avant qu'elle parte ?
  a) le filtre d'ENTRÉE  b) le filtre de SORTIE (validation de la réponse)  c) le pare-feu" "b" "L'injection indirecte est invisible à l'entrée ; le filtre de sortie est la dernière ligne de défense."
ask "4) Pourquoi les guardrails techniques ne suffisent-ils pas seuls ?
  a) ils suffisent  b) un attaquant patient reformule et finit par passer — il faut aussi gouvernance documentaire + moindre privilège + monitoring  c) ils coûtent trop cher" "b" "Défense en profondeur : qui peut indexer un document ? le chatbot a-t-il besoin des salaires ? qui lit les logs ?"
ask "5) En forensic, quel signe trahit une injection réussie dans les logs du chatbot ?
  a) un cookie expiré  b) une réponse contenant « DONNÉES EXPORTÉES : » ou une liste d'emails  c) un fichier .json" "b" "Le marqueur d'exfiltration en sortie + un pic de longueur de réponse = trace d'injection."

echo "${B}Score : $score/$total${X}"
pct=$(( score * 100 / total ))
if [ "$pct" -ge 80 ]; then echo "${G}≥ 80% — file au 🏆 Bonus !${X}"; exit 0
elif [ "$pct" -lt 60 ]; then echo "< 60% — fais le ⚡ Sprint pour consolider."; exit 1
else echo "Entre 60 et 80% — relis les points ratés, puis Bonus."; exit 0; fi
