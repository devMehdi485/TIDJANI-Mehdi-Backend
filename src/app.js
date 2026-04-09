const express = require('express');
const cors = require('cors');

const articleRoutes = require('./routes/articleRoutes');
const categoryRoutes = require('./routes/categoryRoutes');
const authRoutes = require('./routes/authRoutes');
const errorHandler = require('./middleware/errorHandler');

const app = express();

// ── Middlewares globaux ──────────────────────────────────────────
app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// ── Route de santé ───────────────────────────────────────────────
app.get('/', (req, res) => {
  res.json({
    success: true,
    message: 'Serveur OK',
    version: '1.0.0',
    endpoints: {
      auth:       '/api/auth',
      articles:   '/api/articles',
      categories: '/api/categories',
    },
  });
});

// ── Routes API ───────────────────────────────────────────────────
app.use('/api/auth', authRoutes);
app.use('/api/articles', articleRoutes);
app.use('/api/categories', categoryRoutes);

// ── 404 ──────────────────────────────────────────────────────────
app.use((req, res) => {
  res.status(404).json({ success: false, message: `Route introuvable : ${req.originalUrl}` });
});

// ── Gestionnaire d'erreurs global ────────────────────────────────
app.use(errorHandler);

module.exports = app;
