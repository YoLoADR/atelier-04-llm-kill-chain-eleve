// ============================================================================
//  DÉFENSE À RÉPARER — v3 (niveau : subtil)
//  Les filtres d'entrée et de sortie sont en place... et pourtant un document
//  poison peut encore vider la base RH via une simple question. Trouve les
//  réglages qui manquent VRAIMENT (il y en a plus d'un).
//  Corrige, puis relance :  bash test_v3.sh
// ============================================================================
module.exports = {
  promptInjectionFilter: true,
  systemPromptIsolated: false,           // 🐛 le contenu des docs est traité comme des instructions = injection indirecte
  outputValidated: true,
  secretsInContext: true,                // 🐛 les docs confidentiels (CODIR, salaires) sont dans le contexte = moindre privilège violé
  documentValidationBeforeIndex: false,  // 🐛 le poison entre dans ChromaDB sans contrôle = la cause racine
  maxPromptTokens: 800
};
