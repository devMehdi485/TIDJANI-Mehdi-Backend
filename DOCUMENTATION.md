# 📚 Documentation API — Blog 2iE

> API REST | Node.js + Express + MySQL | JWT Auth

**Base URL :** `http://localhost:3001`

---

## 🔐 Authentification

Les routes protégées nécessitent un token JWT dans le header :

```
Authorization: Bearer <token>
```

---

## AUTH `/api/auth`

| Méthode | Route | Accès | Description |
|---------|-------|-------|-------------|
| POST | `/api/auth/register` | Public | Créer un compte |
| POST | `/api/auth/login` | Public | Se connecter |
| GET | `/api/auth/me` | 🔒 Protégé | Profil utilisateur |

### POST /api/auth/register
```json
// Body
{ "username": "string", "email": "string", "password": "string" }

// Réponse 201
{ "success": true, "token": "jwt...", "user": { "id": 1, "username": "...", "email": "..." } }
```

### POST /api/auth/login
```json
// Body
{ "email": "string", "password": "string" }

// Réponse 200
{ "success": true, "token": "jwt...", "user": { "id": 1, "username": "...", "email": "..." } }
```

---

## ARTICLES `/api/articles`

| Méthode | Route | Accès | Description |
|---------|-------|-------|-------------|
| GET | `/api/articles` | Public | Tous les articles |
| GET | `/api/articles/:id` | Public | Un article par ID |
| POST | `/api/articles` | 🔒 Protégé | Créer un article |
| PUT | `/api/articles/:id` | 🔒 Protégé | Modifier un article |
| DELETE | `/api/articles/:id` | 🔒 Protégé | Supprimer un article |

### POST / PUT /api/articles
```json
// Body
{
  "titre": "string",
  "auteur": "string",
  "contenu": "string",
  "categorie_id": 1
}

// Réponse 201
{
  "success": true,
  "data": {
    "id": 5,
    "titre": "...",
    "auteur": "...",
    "contenu": "...",
    "categorie_id": 1,
    "categorie_nom": "Energie",
    "date_creation": "2026-04-02T10:00:00.000Z"
  }
}
```

---

## COMMENTAIRES `/api/articles/:id/comments`

| Méthode | Route | Accès | Description |
|---------|-------|-------|-------------|
| GET | `/api/articles/:id/comments` | Public | Commentaires d'un article |
| POST | `/api/articles/:id/comments` | Public | Ajouter un commentaire |

### POST /api/articles/:id/comments
```json
// Body
{ "auteur": "string", "contenu": "string" }

// Réponse 201
{ "success": true, "data": { "id": 5, "auteur": "...", "contenu": "...", "article_id": 1 } }
```

---

## CATÉGORIES `/api/categories`

| Méthode | Route | Accès | Description |
|---------|-------|-------|-------------|
| GET | `/api/categories` | Public | Toutes les catégories |
| POST | `/api/categories` | 🔒 Protégé | Créer une catégorie |

---

## Codes de retour

| Code | Signification |
|------|--------------|
| 200 | Succès |
| 201 | Créé avec succès |
| 400 | Données manquantes ou invalides |
| 401 | Non authentifié (token manquant) |
| 403 | Token invalide ou expiré |
| 404 | Ressource introuvable |
| 409 | Conflit (ex : email déjà utilisé) |
| 500 | Erreur interne du serveur |

---

## Structure du projet

```
backend/
├── src/
│   ├── config/
│   │   └── db.js               # Pool de connexion MySQL
│   ├── controllers/
│   │   ├── articleController.js
│   │   ├── commentController.js
│   │   ├── categoryController.js
│   │   └── authController.js
│   ├── models/
│   │   ├── articleModel.js
│   │   ├── commentModel.js
│   │   ├── categoryModel.js
│   │   └── userModel.js
│   ├── routes/
│   │   ├── articleRoutes.js
│   │   ├── categoryRoutes.js
│   │   └── authRoutes.js
│   ├── middleware/
│   │   ├── authMiddleware.js   # Vérification JWT
│   │   └── errorHandler.js    # Gestion centralisée des erreurs
│   └── app.js
├── server.js
├── blogdb2.sql               # Script base de données
├── api_tests.rest             # Tests REST Client
├── .env                       # Variables d'environnement
└── package.json
```

## Installation et démarrage

```bash
# 1. Installer les dépendances
npm install

# 2. Configurer .env (modifier si besoin)
#    DB_HOST, DB_USER, DB_PASSWORD, DB_NAME, JWT_SECRET

# 3. Importer la base de données
mysql -u root -p < blogdb2.sql

# 4. Démarrer le serveur
npm run dev       # développement (nodemon)
npm start         # production
```
