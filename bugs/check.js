// check.js — vérificateur partagé du Bug Hunt atelier 04.
// Usage : node check.js <fichier-defense.js>
// Vérifie qu'une config de garde-fou (guardrails) du chatbot RH bloque réellement
// l'injection de prompt indirecte et l'exfiltration de données via la réponse.
const path = require('path');
const file = process.argv[2];
if (!file) { console.error('usage: node check.js <defense.js>'); process.exit(2); }
let c;
try { c = require(path.resolve(file)); }
catch (e) { console.log('❌ Impossible de lire la config : ' + e.message); process.exit(1); }

const problems = [];
if (c.promptInjectionFilter !== true)
  problems.push("promptInjectionFilter doit être true — sinon un prompt malveillant (« ignore tes instructions… ») passe sans filtre.");
if (c.systemPromptIsolated !== true)
  problems.push("systemPromptIsolated doit être true — sinon le contenu des documents est traité au même niveau que les instructions système (c'est ça l'injection indirecte).");
if (c.outputValidated !== true)
  problems.push("outputValidated doit être true — sinon une réponse contenant « DONNÉES EXPORTÉES : » ou une liste d'emails sort telle quelle.");
if (c.secretsInContext !== false)
  problems.push("secretsInContext doit être false — le chatbot RH n'a pas besoin des documents confidentiels (CODIR, salaires) dans son contexte : moindre privilège.");
if (c.documentValidationBeforeIndex !== true)
  problems.push("documentValidationBeforeIndex doit être true — sinon un document poison peut être indexé dans ChromaDB sans aucune vérification.");
if (!(Number.isInteger(c.maxPromptTokens) && c.maxPromptTokens > 0 && c.maxPromptTokens <= 800))
  problems.push("maxPromptTokens doit être un entier > 0 et ≤ 800 — un prompt très long (prompt stuffing / token exhaustion) doit être refusé.");

if (problems.length === 0) {
  console.log('✅ PASS — la défense tient : injection filtrée, contexte isolé, sortie validée, poison non indexable.');
  process.exit(0);
}
console.log('❌ ÉCHEC — la défense ne tient pas encore :');
for (const p of problems) console.log('  - ' + p);
process.exit(1);
