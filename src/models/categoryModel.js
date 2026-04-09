const db = require('../config/db');

const Category = {
  // Récupérer toutes les catégories
  getAll: async () => {
    const [rows] = await db.query('SELECT * FROM categories ORDER BY name ASC');
    return rows;
  },

  // Ajouter une catégorie (optionnel)
  create: async ({ name, slug, description }) => {
    const [result] = await db.query(
      'INSERT INTO categories (name, slug, description) VALUES (?, ?, ?)',
      [name, slug, description ?? null]
    );
    return result.insertId;
  },

  // Vérifier si une catégorie existe
  getById: async (id) => {
    const [rows] = await db.query('SELECT * FROM categories WHERE id = ?', [id]);
    return rows[0];
  },
};

module.exports = Category;
