const db = require('../config/db');

const Article = {
  // Récupérer tous les articles avec le nom de la catégorie
  getAll: async () => {
    const [rows] = await db.query(`
      SELECT a.*, c.name AS category_name, c.slug AS category_slug
      FROM articles a
      LEFT JOIN categories c ON a.category_id = c.id
      ORDER BY a.created_at DESC
    `);
    return rows;
  },

  // Récupérer un article par ID
  getById: async (id) => {
    const [rows] = await db.query(`
      SELECT a.*, c.name AS category_name, c.slug AS category_slug
      FROM articles a
      LEFT JOIN categories c ON a.category_id = c.id
      WHERE a.id = ?
    `, [id]);
    return rows[0];
  },

  // Créer un article
  create: async ({ title, content, author, category, excerpt, image, date, tags, category_id }) => {
    const [result] = await db.query(
      `INSERT INTO articles (title, content, author, category, excerpt, image, date, tags, category_id)
       VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)`,
      [title, content, author, category ?? null, excerpt ?? null, image ?? null, date ?? null, tags ?? null, category_id ?? null]
    );
    return result.insertId;
  },

  // Modifier un article
  update: async (id, { title, content, author, category, excerpt, image, date, tags, category_id }) => {
    const [result] = await db.query(
      `UPDATE articles SET title = ?, content = ?, author = ?, category = ?,
       excerpt = ?, image = ?, date = ?, tags = ?, category_id = ? WHERE id = ?`,
      [title, content, author, category ?? null, excerpt ?? null, image ?? null, date ?? null, tags ?? null, category_id ?? null, id]
    );
    return result.affectedRows;
  },

  // Supprimer un article
  delete: async (id) => {
    const [result] = await db.query('DELETE FROM articles WHERE id = ?', [id]);
    return result.affectedRows;
  },
};

module.exports = Article;
