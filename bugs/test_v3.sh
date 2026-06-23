#!/usr/bin/env bash
# Bug Hunt atelier 04 — test v3. Rejoue (en local) la logique de l'attaque
# (injection de prompt + exfiltration) contre ta config de garde-fous.
# Vert seulement si l'attaque serait bloquée.
cd "$(dirname "$0")"
node check.js v3-defense.js
