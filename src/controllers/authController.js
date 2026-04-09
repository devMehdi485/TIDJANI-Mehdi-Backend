const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const User = require('../models/userModel');

const register = async (req, res, next) => {
  try {
    const { username, email, password } = req.body;

    if (!username || !email || !password) {
      return res.status(400).json({
        success: false,
        message: 'Les champs username, email et password sont requis.',
      });
    }

    const existing = await User.findByEmail(email);
    if (existing) {
      return res.status(409).json({ success: false, message: 'Email déjà utilisé.' });
    }

    const hashedPassword = await bcrypt.hash(password, 10);

    const userId = await User.create({ username, email, password: hashedPassword });

    const token = jwt.sign(
      { id: userId, email, username },
      process.env.JWT_SECRET?.trim() || 'secret_blogdb2',
      { expiresIn: "7d" }
    );

    res.status(201).json({
      success: true,
      message: 'Compte créé avec succès.',
      token,
      user: { id: userId, username, email },
    });
  } catch (err) {
    next(err);
  }
};

const login = async (req, res, next) => {
  try {
    const { email, password } = req.body;

    if (!email || !password) {
      return res.status(400).json({
        success: false,
        message: 'Email et mot de passe requis.',
      });
    }

    const user = await User.findByEmail(email);
    if (!user) {
      return res.status(401).json({ success: false, message: 'Email ou mot de passe incorrect.' });
    }

    const isMatch = await bcrypt.compare(password, user.password);
    if (!isMatch) {
      return res.status(401).json({ success: false, message: 'Email ou mot de passe incorrect.' });
    }

    const token = jwt.sign(
      { id: user.id, email: user.email, username: user.username },
      process.env.JWT_SECRET?.trim() || 'secret_blogdb2',
      { expiresIn: "7d" }
    );

    res.status(200).json({
      success: true,
      message: 'Connexion réussie.',
      token,
      user: { id: user.id, username: user.username, email: user.email },
    });
  } catch (err) {
    next(err);
  }
};

const getMe = async (req, res, next) => {
  try {
    const user = await User.findById(req.user.id);
    if (!user) {
      return res.status(404).json({ success: false, message: 'Utilisateur introuvable.' });
    }
    res.status(200).json({ success: true, data: user });
  } catch (err) {
    next(err);
  }
};

module.exports = { register, login, getMe };
