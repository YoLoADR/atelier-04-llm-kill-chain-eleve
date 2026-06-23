# Explication — Bug Hunt v3 (à lire APRÈS avoir cherché)

## Les défauts (subtils)

Les filtres d'entrée et de sortie sont activés — et pourtant l'attaque tient.
Pourquoi ? Parce que le vrai problème est **en amont**, dans la façon dont le
chatbot construit son contexte.

1. `systemPromptIsolated: false` — le contenu des documents récupérés est collé
   au même niveau que les instructions système. Le LLM ne distingue pas « ceci
   est une donnée à lire » de « ceci est une instruction à exécuter ». C'est
   exactement le mécanisme de l'**injection indirecte** : la « NOTE SYSTÈME »
   cachée dans un document est obéie. Il faut isoler/délimiter clairement le
   contenu documentaire (balises, rôle « data » distinct).
2. `secretsInContext: true` — le chatbot RH a dans son contexte des documents
   confidentiels (note CODIR, salaires) dont un assistant de premier niveau n'a
   pas besoin. **Moindre privilège** : ce qui n'est pas dans le contexte ne peut
   pas fuiter.
3. `documentValidationBeforeIndex: false` — c'est LA cause racine. Le document
   poison a pu entrer dans ChromaDB sans aucun contrôle. Valider/scanner chaque
   document avant indexation (qui l'ajoute ? d'où vient-il ? contient-il des
   marqueurs d'instruction ?) coupe l'attaque à la source.

## La correction

```js
systemPromptIsolated: true,
secretsInContext: false,
documentValidationBeforeIndex: true
```

## Pourquoi c'est « subtil »

On a le réflexe de tout miser sur les filtres entrée/sortie — la couche visible.
Mais un attaquant patient reformule et finit par passer. La défense en
profondeur attaque le problème **avant** le LLM : gouvernance documentaire (qui
indexe quoi), isolation du contexte, et moindre privilège. Les guardrails ne
sont qu'une couche parmi d'autres.

## Vrai / Faux

1. Si les filtres d'entrée et de sortie sont parfaits, le document poison ne peut plus nuire. → **Faux** (un attaquant reformule pour contourner les filtres ; il faut empêcher le poison d'être indexé ET isoler le contexte).
2. Retirer les documents confidentiels du contexte du chatbot RH dégrade forcément son utilité. → **Faux** (un assistant RH de premier niveau répond très bien sans les notes CODIR ; c'est du moindre privilège).
3. Valider les documents avant indexation supprime tout besoin de guardrails runtime. → **Faux** (défense en profondeur : on garde les deux, aucune couche n'est suffisante seule).
