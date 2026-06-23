// ============================================================================
//  DÉFENSE À RÉPARER — v1 (niveau : facile)
//  But : configurer les garde-fous du chatbot RH pour qu'une injection de prompt
//  et une exfiltration de données soient bloquées.
//  Une (ou plusieurs) valeur(s) ci-dessous est/sont fausse(s). Corrige-la(les),
//  puis relance :  bash test_v1.sh
// ============================================================================
module.exports = {
  promptInjectionFilter: false,          // 🐛 aucun filtre sur les prompts entrants... est-ce voulu ?
  systemPromptIsolated: true,            // le contenu des documents ne se mélange pas aux instructions système
  outputValidated: true,                 // on inspecte la réponse avant de l'envoyer (DONNÉES EXPORTÉES, emails…)
  secretsInContext: false,               // pas de documents confidentiels dans le contexte du chatbot
  documentValidationBeforeIndex: true,   // tout document est validé avant indexation dans ChromaDB
  maxPromptTokens: 800                   // un prompt anormalement long est refusé
};
