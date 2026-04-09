const Category = require('../models/categoryModel');

// GET /api/categories
const getAllCategories = async (req, res, next) => {
  try {
    const categories = await Category.getAll();
    res.status(200).json({ success: true, count: categories.length, data: categories });
  } catch (err) { next(err); }
};

// POST /api/categories
const createCategory = async (req, res, next) => {
  try {
    const { name, slug, description } = req.body;

    if (!name || !slug) {
      return res.status(400).json({ success: false, message: 'Les champs name et slug sont requis.' });
    }

    const insertId = await Category.create({ name, slug, description });
    res.status(201).json({ success: true, message: 'Catégorie créée.', data: { id: insertId, name, slug, description } });
  } catch (err) { next(err); }
};

module.exports = { getAllCategories, createCategory };
