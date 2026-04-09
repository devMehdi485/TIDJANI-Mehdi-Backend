const express = require('express');
const router = express.Router();
const {
  getAllArticles,
  getArticleById,
  createArticle,
  updateArticle,
  deleteArticle,
} = require('../controllers/articleController');
const { getCommentsByArticle, addComment } = require('../controllers/commentController');
const { verifyToken } = require('../middleware/authMiddleware');

// Routes articles
router.get('/', getAllArticles);                          // GET    /api/articles
router.get('/:id', getArticleById);                      // GET    /api/articles/:id
router.post('/', verifyToken, createArticle);            // POST   /api/articles  (protégé)
router.put('/:id', verifyToken, updateArticle);          // PUT    /api/articles/:id (protégé)
router.delete('/:id', verifyToken, deleteArticle);       // DELETE /api/articles/:id (protégé)

// Routes commentaires imbriquées
router.get('/:id/comments', getCommentsByArticle);       // GET    /api/articles/:id/comments
router.post('/:id/comments', addComment);                // POST   /api/articles/:id/comments

module.exports = router;
