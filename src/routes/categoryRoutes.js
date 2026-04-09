const express = require('express');
const router = express.Router();
const { getAllCategories, createCategory } = require('../controllers/categoryController');
const { verifyToken } = require('../middleware/authMiddleware');

router.get('/', getAllCategories);                        // GET  /api/categories
router.post('/', verifyToken, createCategory);           // POST /api/categories (protégé)

module.exports = router;
