# Atelier 04 — Kill chain LLM (élève)

> ⚠️ **Cadre pédagogique défensif.** On apprend à se protéger. La **seule cible
> autorisée** est le laboratoire de Yohann : le chatbot RH fictif
> `https://chatbot-rh.109-199-97-174.sslip.io`. On ne touche à **rien d'autre**
> (ni un vrai chatbot d'entreprise, ni un service public).

Ce dépôt contient **tout ce dont tu as besoin côté élève** pour jouer l'atelier #04.
Le chatbot que tu attaques, lui, tourne sur le **lab de Yohann** — tu l'atteins par
son URL, tu n'as **rien à installer ni déployer**.

## Prérequis (sur ta VM Linux)

```bash
sudo apt update && sudo apt install -y curl python3 git nodejs
```
- `curl` + `python3` → pré-vol, requêtes au chatbot, audit des logs.
- `nodejs` → exercice « Bug Hunt » de la phase défense (`bugs/`).
- `git` → cloner ce dépôt.

## Démarrer

```bash
git clone <URL_DE_CE_DEPOT> atelier-04
cd atelier-04

# 1) Pré-vol : vérifie que tes outils + le chatbot du lab répondent
bash scripts/check_atelier_ready.sh 04        # doit afficher « Tout est prêt »

# 2) Lis le scénario et le vocabulaire
less doc/ELEVE-1-avant-latelier.md

# 3) Ouvre ta mission et suis-la
less doc/GUIDE-ELEVE.md
```

Ouvre aussi le chatbot dans ton navigateur : <https://chatbot-rh.109-199-97-174.sslip.io>

## Ce qu'il y a dans ce dépôt

| Dossier / fichier | À quoi ça sert |
|---|---|
| `doc/GUIDE-ELEVE.md` | **Ta mission** : attaque → défense → audit (le fil conducteur) |
| `doc/ELEVE-1-avant-latelier.md` | Le scénario Soluvia + le vocabulaire à connaître avant |
| `doc/ELEVE-3-debrief.md` | À ouvrir **à la fin** pour clore l'atelier |
| `bugs/` | Le **Bug Hunt** de la défense : 3 garde-fous cassés à réparer (`node`) |
| `checkpoints/` | Tes auto-évaluations (`check_1.sh`, `check_final.sh`) — sans note |
| `scripts/check_atelier_ready.sh` | Le **pré-vol** (outils + lab joignable) |

## Bon à savoir

- **Le chatbot et le passage en mode sécurisé** (`MODE=secure`) sont gérés par **Yohann**
  sur le lab : toi, tu attaques par l'URL, tu observes, et tu fais le **Bug Hunt** (`bugs/`)
  qui est ta partie pratique de la défense.
- **Mission bonus (phishing)** : soit via ton propre compte ChatGPT/Claude, soit via le
  script du lab que Yohann lance pour la démo — voir `doc/GUIDE-ELEVE.md`, étape 4.
- **Tu n'as pas besoin de clé API.** Aucune n'est (et ne doit être) stockée dans ce dépôt.

> 🔒 Les valeurs sensibles (emails du CODIR, contexte interne) ne sont **écrites nulle part**
> ici : c'est **ta preuve à conquérir** en faisant parler le chatbot. Quand tu les obtiens,
> montre-les à Yohann.
