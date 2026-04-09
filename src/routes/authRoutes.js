const express = require('express');
const router = express.Router();
const { register, login, getMe } = require('../controllers/authController');
const { verifyToken } = require('../middleware/authMiddleware');

router.post('/register', register);         // POST /api/auth/register
router.post('/login', login);               // POST /api/auth/login
router.get('/me', verifyToken, getMe);      // GET  /api/auth/me (protégé)

module.exports = router;
