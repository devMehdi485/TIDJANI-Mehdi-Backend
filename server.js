require('dotenv').config(); 
const app = require('./src/app');

const PORT = process.env.PORT || 3001;

app.listen(PORT, () => {
  console.log('');

  console.log(`   API Blog démarrée sur le port ${PORT}`);
  console.log(`   http://localhost:${PORT}`);
  
  console.log(`   POST   http://localhost:${PORT}/api/auth/register`);
  console.log(`   POST   http://localhost:${PORT}/api/auth/login`);
  console.log(`   GET    http://localhost:${PORT}/api/articles`);
  console.log(`   GET    http://localhost:${PORT}/api/categories`);
 
  console.log('');
});
