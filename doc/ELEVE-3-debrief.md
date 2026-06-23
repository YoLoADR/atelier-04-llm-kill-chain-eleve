# Atelier 04 — Débrief (10 min)

Tu as fini : tu as fait fuiter des données d'un chatbot juste en lui parlant, tu
as vu un LLM fabriquer des emails d'arnaque en quelques secondes, puis tu as posé
des garde-fous et audité les traces. Prends 10 minutes pour **ancrer** ce que tu
retiens — c'est cette étape qui transforme « j'ai suivi des commandes » en « j'ai
compris ».

## La question à te poser

> *Si demain ton entreprise (ou ton école) branchait un assistant IA sur tous ses
> documents internes, qu'est-ce que tu vérifierais **avant** de lui faire confiance ?*

Réfléchis 1 minute en silence, puis écris ta réponse. Il n'y a pas de bonne
réponse : le but est de voir que la défense, ce n'est pas que de la technique,
c'est aussi de la **gouvernance** (qui met quoi dans la base) et des **habitudes**.

Quelques pistes (coche celles que tu adoptes) :

- [ ] Me **méfier d'un mail trop parfait** : zéro faute, ton lisse, urgence polie
      → ça peut être généré par une IA.
- [ ] **Vérifier hors-canal** (un appel, un message direct) avant de cliquer sur
      un lien ou de valider un virement « urgent ».
- [ ] Ne **jamais coller** d'info confidentielle dans un chatbot public (ce que tu
      écris peut être enregistré ailleurs).
- [ ] Me demander **quels documents** un assistant IA peut lire avant de lui faire
      confiance.
- [ ] Repérer qu'un chatbot peut **mentir** sur sa nature s'il a été configuré pour.

## Les 3 idées à emporter

1. **Un LLM ne distingue pas données et instructions** : tout ce qui est dans son
   contexte peut être pris pour un ordre. Une instruction cachée dans un document
   suffit à le détourner — c'est l'injection **indirecte**.
2. **Aucune défense ne suffit seule** : filtre d'entrée, filtre de sortie,
   isolation du contexte, validation des documents, moindre privilège, monitoring…
   elles se complètent. Un attaquant patient reformule jusqu'à passer.
3. **L'IA industrialise l'arnaque** : 5 emails ciblés en quelques secondes, sans
   faute, personnalisés. La barrière à l'entrée du phishing a disparu — d'où
   l'importance du réflexe humain « je vérifie avant de cliquer ».

## À ramener chez toi (cette semaine)

- Repère **un** outil IA que tu utilises et demande-toi : à quels documents
  a-t-il accès ? qui peut y ajouter du contenu ?
- La prochaine fois que tu reçois un mail « urgent » avec un lien, **trouve l'IOC**
  qui trahirait une génération par IA (ou une arnaque) avant de cliquer.
- Explique à quelqu'un, en une phrase, pourquoi « le chatbot a juste répondu à une
  question normale » peut quand même être une fuite de données.
