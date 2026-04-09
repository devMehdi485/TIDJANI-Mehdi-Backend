const Comment = require('../models/commentModel');
const Article = require('../models/articleModel');

// GET /api/articles/:id/comments
const getCommentsByArticle = async (req, res, next) => {
  try {
    const article = await Article.getById(req.params.id);
    if (!article) return res.status(404).json({ success: false, message: 'Article introuvable.' });

    const comments = await Comment.getByArticle(req.params.id);
    res.status(200).json({ success: true, count: comments.length, data: comments });
  } catch (err) { next(err); }
};

// POST /api/articles/:id/comments
const addComment = async (req, res, next) => {
  try {
    const { author, content, date } = req.body;
    const article_id = req.params.id;

    if (!author || !content) {
      return res.status(400).json({ success: false, message: 'Les champs author et content sont requis.' });
    }

    const article = await Article.getById(article_id);
    if (!article) return res.status(404).json({ success: false, message: 'Article introuvable.' });

    const insertId = await Comment.create({ author, content, article_id, date });
    res.status(201).json({ success: true, message: 'Commentaire ajouté.', data: { id: insertId, author, content, article_id } });
  } catch (err) { next(err); }
};

module.exports = { getCommentsByArticle, addComment };
