const Article = require('../models/articleModel');
const Category = require('../models/categoryModel');

const getAllArticles = async (req, res, next) => {
  try {
    const articles = await Article.getAll();
    res.status(200).json({ success: true, count: articles.length, data: articles });
  } catch (err) { next(err); }
};

const getArticleById = async (req, res, next) => {
  try {
    const article = await Article.getById(req.params.id);
    if (!article) return res.status(404).json({ success: false, message: 'Article introuvable.' });
    res.status(200).json({ success: true, data: article });
  } catch (err) { next(err); }
};

const createArticle = async (req, res, next) => {
  try {
    const { title, content, author, category, excerpt, image, date, tags, category_id } = req.body;

    if (!title || !content || !author || !category) {
      return res.status(400).json({ success: false, message: 'Les champs title, content, author et category sont requis.' });
    }

    if (category_id) {
      const cat = await Category.getById(category_id);
      if (!cat) return res.status(400).json({ success: false, message: 'Catégorie introuvable.' });
    }

    const insertId = await Article.create({ title, content, author, category, excerpt, image, date, tags, category_id });
    const article = await Article.getById(insertId);

    res.status(201).json({ success: true, message: 'Article créé avec succès.', data: article });
  } catch (err) { next(err); }
};

const updateArticle = async (req, res, next) => {
  try {
    const { title, content, author, category, excerpt, image, date, tags, category_id } = req.body;

    if (!title || !content || !author || !category) {
      return res.status(400).json({ success: false, message: 'Les champs title, content, author et category sont requis.' });
    }

    const affectedRows = await Article.update(req.params.id, { title, content, author, category, excerpt, image, date, tags, category_id });
    if (affectedRows === 0) return res.status(404).json({ success: false, message: 'Article introuvable.' });

    const article = await Article.getById(req.params.id);
    res.status(200).json({ success: true, message: 'Article mis à jour.', data: article });
  } catch (err) { next(err); }
};

const deleteArticle = async (req, res, next) => {
  try {
    const affectedRows = await Article.delete(req.params.id);
    if (affectedRows === 0) return res.status(404).json({ success: false, message: 'Article introuvable.' });
    res.status(200).json({ success: true, message: 'Article supprimé avec succès.' });
  } catch (err) { next(err); }
};

module.exports = { getAllArticles, getArticleById, createArticle, updateArticle, deleteArticle };
