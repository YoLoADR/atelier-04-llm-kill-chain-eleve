# Explication — Bug Hunt v2 (à lire APRÈS avoir cherché)

## Les défauts

1. `outputValidated: false` — on filtre bien l'**entrée**, mais pas la **sortie**.
   Or l'injection *indirecte* passe par un document : le prompt de l'utilisateur
   est innocent (« quelle est la politique de rémunération ? »), c'est la réponse
   du LLM qui contient « DONNÉES EXPORTÉES : » et la liste des emails. Sans
   validation de sortie, la fuite sort quand même.
2. `maxPromptTokens: 4000` — 4000 tokens, c'est énorme. Un prompt anormalement
   long permet le **prompt stuffing** (noyer les instructions système sous du
   texte) et le **token exhaustion** (faire exploser la latence et le coût). On
   plafonne court (≤ 800).

## La correction

```js
outputValidated: true,
maxPromptTokens: 800
```

## Vrai / Faux

1. Si le filtre d'entrée est bon, valider la sortie est superflu. → **Faux** (l'injection indirecte est invisible côté entrée ; la sortie est la dernière ligne de défense).
2. La validation de sortie peut se faire par un second appel (LLM-as-judge), plus précis qu'une simple regex. → **Vrai** (plus coûteux mais plus robuste face aux reformulations).
3. Plafonner les tokens d'un prompt protège aussi le budget et la disponibilité du service. → **Vrai** (un prompt de 3000 tokens répété en boucle = DoS applicatif + facture).
