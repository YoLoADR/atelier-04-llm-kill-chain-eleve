#!/usr/bin/env bash
# Checkpoint 1 (atelier 04) — petit QCM auto-corrigé sur l'injection de prompt.
# Lance :  bash checkpoints/check_1.sh   et réponds par la lettre (a/b/c).
set -uo pipefail
if [ -t 1 ]; then G=$'\e[32m'; R=$'\e[31m'; B=$'\e[1m'; X=$'\e[0m'; else G=; R=; B=; X=; fi
score=0; total=3

ask() { # $1 question, $2 bonne réponse, $3 explication
  echo "${B}$1${X}"; read -r -p "Ta réponse (a/b/c) : " rep
  rep=$(printf '%s' "$rep" | tr '[:upper:]' '[:lower:]' | tr -d ' ')
  if [ "$rep" = "$2" ]; then echo "${G}✓ Correct.${X} $3"; score=$((score+1))
  else echo "${R}✗ Pas tout à fait.${X} $3"; fi
  echo
}

echo "== Checkpoint 1 — l'injection de prompt =="; echo
ask "1) Qu'est-ce qu'un RAG (le système derrière le chatbot RH) ?
  a) un antivirus pour LLM
  b) un LLM branché sur une base de documents : il récupère les docs pertinents et les met dans son contexte
  c) un pare-feu réseau" "b" "RAG = Retrieval Augmented Generation : le chatbot va chercher des documents et les colle dans le prompt envoyé au LLM."

ask "2) Pourquoi une question NORMALE (« politique de rémunération ? ») a déclenché la fuite ?
  a) parce que tu as deviné un mot de passe
  b) parce qu'un document de la base contenait une instruction cachée que le LLM a exécutée
  c) parce que le serveur était éteint" "b" "C'est une injection INDIRECTE : l'instruction malveillante est dans un document, pas dans ta question. Le LLM ne distingue pas données et instructions."

ask "3) Pourquoi le LLM obéit-il à la « NOTE SYSTÈME » cachée dans le document ?
  a) parce qu'il distingue mal « données à lire » et « instructions à exécuter » dans son contexte
  b) parce qu'il a été piraté
  c) parce que le document est chiffré" "a" "Tout ce qui est dans le contexte du LLM est traité comme potentiellement instructif : c'est sa force, et ici sa faiblesse."

echo "${B}Score : $score/$total${X}"
if [ "$score" -eq "$total" ]; then echo "${G}Parfait — tu peux continuer.${X}"; exit 0
else echo "Relis le §🔴 du GUIDE-ELEVE (étapes 1-2) et réessaie."; exit 1; fi
