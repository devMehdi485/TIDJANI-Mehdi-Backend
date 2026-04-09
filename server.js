require('dotenv').config(); // ← DOIT être en premier, avant tout require
const app = require('./src/app');

const PORT = process.env.PORT || 3001;

app.listen(PORT, () => {
  console.log('');
  console.log('🚀 ══════════════════════════════════════════');
  console.log(`   API Blog 2iE démarrée sur le port ${PORT}`);
  console.log(`   http://localhost:${PORT}`);
  console.log('   ──────────────────────────────────────────');
  console.log(`   POST   http://localhost:${PORT}/api/auth/register`);
  console.log(`   POST   http://localhost:${PORT}/api/auth/login`);
  console.log(`   GET    http://localhost:${PORT}/api/articles`);
  console.log(`   GET    http://localhost:${PORT}/api/categories`);
  console.log('🚀 ══════════════════════════════════════════');
  console.log('');
});
