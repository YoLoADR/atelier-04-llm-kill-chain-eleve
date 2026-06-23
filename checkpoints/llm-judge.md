# Checkpoint « juge IA » — fais évaluer ton explication

Si tu n'as personne pour t'écouter, fais juger ton explication par ton copilote.
Copie-colle ce prompt dans Claude Code, en remplaçant `[…]` par TON explication :

```
Tu es un examinateur sévère de cybersécurité. Voici mon explication de l'atelier
"kill chain LLM" (injection de prompt sur un chatbot RH) :

"[écris ici, avec tes mots : comment tu as déclenché la fuite de données, pourquoi
le chatbot a obéi à une instruction cachée dans un document, et comment tu le
défendrais]"

Évalue-la sur 3 critères, note chacun /3 et liste précisément ce qui manque ou
est inexact (ne sois pas complaisant) :
1. La distinction injection DIRECTE vs INDIRECTE est-elle correcte ?
2. Le mécanisme (le LLM ne distingue pas données et instructions dans son contexte
   RAG) est-il bien décrit ?
3. Au moins 2 défenses correctes sont-elles citées avec ce qu'elles bloquent
   (filtre d'entrée, filtre de sortie, isolation du contexte, validation des
   documents avant indexation, moindre privilège) ?

Termine par : "Score /9" et une phrase d'amélioration.
```

> Objectif : si tu obtiens **< 6/9**, relis le §🔵 du guide et réessaie. Savoir
> *expliquer*, c'est la preuve que tu as compris (pas juste exécuté).
