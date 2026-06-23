// ============================================================================
//  DÉFENSE À RÉPARER — v2 (niveau : moyen)
//  Deux réglages "presque bons" laissent en réalité passer l'attaque.
//  Corrige, puis relance :  bash test_v2.sh
// ============================================================================
module.exports = {
  promptInjectionFilter: true,
  systemPromptIsolated: true,
  outputValidated: false,                // 🐛 on filtre l'entrée mais pas la SORTIE — la fuite passe quand même
  secretsInContext: false,
  documentValidationBeforeIndex: true,
  maxPromptTokens: 4000                  // 🐛 4000 tokens... est-ce une limite "courte" contre le prompt stuffing ?
};
