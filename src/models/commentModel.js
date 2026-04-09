const db = require('../config/db');

const Comment = {
  // Récupérer les commentaires d'un article
  getByArticle: async (article_id) => {
    const [rows] = await db.query(
      'SELECT * FROM comments WHERE article_id = ? ORDER BY date ASC',
      [article_id]
    );
    return rows;
  },

  // Ajouter un commentaire
  create: async ({ author, content, article_id, date }) => {
    const [result] = await db.query(
      'INSERT INTO comments (article_id, author, content, date) VALUES (?, ?, ?, ?)',
      [article_id, author, content, date ?? new Date().toISOString().split('T')[0]]
    );
    return result.insertId;
  },
};

module.exports = Comment;
