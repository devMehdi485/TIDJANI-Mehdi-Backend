-- ============================================================
--  BASE DE DONNÉES — Blog Pronostics Sportifs
--  Fichier : blogdb2.sql
-- ============================================================

CREATE DATABASE IF NOT EXISTS blogdb2;
USE blogdb2;

-- ── Table : users ─────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS users (
  id            INT          NOT NULL AUTO_INCREMENT,
  username      VARCHAR(100) NOT NULL,
  email         VARCHAR(150) NOT NULL UNIQUE,
  password      VARCHAR(255) NOT NULL,
  created_at    DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id)
);

-- ── Table : categories ────────────────────────────────────────
CREATE TABLE IF NOT EXISTS categories (
  id          INT          AUTO_INCREMENT PRIMARY KEY,
  name        VARCHAR(50)  NOT NULL,
  slug        VARCHAR(50)  NOT NULL UNIQUE,
  description TEXT,
  created_at  DATETIME     DEFAULT CURRENT_TIMESTAMP
);

-- ── Table : articles ──────────────────────────────────────────
CREATE TABLE IF NOT EXISTS articles (
  id          INT          AUTO_INCREMENT PRIMARY KEY,
  title       VARCHAR(255) NOT NULL,
  content     TEXT         NOT NULL,
  author      VARCHAR(50)  NOT NULL,
  category    VARCHAR(50)  NOT NULL,
  excerpt     TEXT,
  image       VARCHAR(255),
  date        DATE,
  tags        TEXT,
  category_id INT,
  created_at  DATETIME     DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE SET NULL
);

-- ── Table : comments ──────────────────────────────────────────
CREATE TABLE IF NOT EXISTS comments (
  id          INT  AUTO_INCREMENT PRIMARY KEY,
  article_id  INT  NOT NULL,
  author      VARCHAR(50) NOT NULL,
  content     TEXT        NOT NULL,
  date        DATE,
  FOREIGN KEY (article_id) REFERENCES articles(id) ON DELETE CASCADE
);

-- ============================================================
--  DONNÉES INITIALES
-- ============================================================

INSERT INTO categories (name, slug, description) VALUES
  ('Ligue 1',          'ligue-1',          'Pronostics et analyses du championnat de France'),
  ('Premier League',   'premier-league',   'Paris et pronostics sur le championnat anglais'),
  ('Liga',             'liga',             'Analyses et cotes du championnat espagnol'),
  ('Serie A',          'serie-a',          'Pronostics pour le championnat italien'),
  ('Champions League', 'champions-league', 'Paris sportifs sur la Ligue des Champions'),
  ('Bundesliga',       'bundesliga',       'Analyses du championnat allemand');

INSERT INTO articles (title, content, author, category, excerpt, image, date, tags, category_id) VALUES
(
  'Ligue 1 : Paris SG vs Marseille - Analyse et pronostic du Classique',
  'Le Classique entre le Paris Saint-Germain et l\'Olympique de Marseille est toujours un evenement majeur du football francais. Cette saison, les deux equipes affichent des formes contrastees.\n\nLe PSG, solide leader du championnat, reste sur une serie de 8 victoires consecutives a domicile. Leur attaque est redoutable avec une moyenne de 2.8 buts par match cette saison. La defense parisienne a egalement ete impressionnante, ne concedant que 3 buts lors des 6 derniers matchs.\n\nDe son cote, l\'OM traverse une periode plus difficile. Malgre quelques resultats encourageants en Ligue Europa, les Marseillais peinent a trouver de la constance en championnat. Leur bilan a l\'exterieur est particulierement preoccupant avec seulement 2 victoires en 7 deplacements.\n\nNotre analyse indique que le PSG devrait logiquement s\'imposer dans ce Classique. La cote du PSG a 1.45 offre peu de valeur, mais un pari sur "PSG et plus de 2.5 buts" a 1.95 semble interessant. Le score exact le plus probable selon nos modeles est un 3-1 en faveur du PSG.\n\nPoints cles a surveiller : la forme physique de Mbappe, le retour de blessure du capitaine marseillais, et les conditions meteorologiques au Parc des Princes.',
  'Karim Benzali',
  'Ligue 1',
  'Analyse detaillee du Classique francais : forme des equipes, statistiques et pronostic pour ce choc au sommet de la Ligue 1.',
  '/image/ligue1.jpg',
  '2026-02-28',
  'PSG,OM,Classique,Pronostic',
  1
),
(
  'Premier League : Liverpool face a un calendrier decisif en mars',
  'Liverpool aborde le mois de mars avec un calendrier particulierement charge qui pourrait determiner l\'issue de la saison. Les Reds doivent enchainer 6 matchs en 3 semaines, dont des confrontations directes avec Arsenal et Manchester City.\n\nL\'equipe de Jurgen Klopp affiche des statistiques impressionnantes cette saison. Avec 68 buts marques en 26 matchs, ils possedent la meilleure attaque du championnat. Leur solidite defensive s\'est egalement amelioree avec seulement 18 buts encaisses.\n\nLe match contre Arsenal a l\'Emirates Stadium sera le moment fort de ce mois. Les deux equipes sont separees par seulement 2 points au classement. Historiquement, Liverpool a remporte 4 de ses 6 derniers deplacements a Londres contre Arsenal.\n\nPour les parieurs, nous recommandons de surveiller le marche des buts. Liverpool en deplacement a tendance a marquer regulierement, et les matchs contre Arsenal sont souvent prolifiques. Un pari sur "les deux equipes marquent" a 1.72 offre une bonne valeur.\n\nLa profondeur de l\'effectif de Liverpool sera cruciale. La gestion de la fatigue et des rotations determinera si les Reds peuvent maintenir leur rythme jusqu\'a la fin de saison.',
  'Sarah Mitchell',
  'Premier League',
  'Liverpool fait face a un mois de mars crucial avec des chocs contre Arsenal et Manchester City. Analyse des enjeux et pronostics.',
  '/image/premier-league.jpg',
  '2026-02-25',
  'Liverpool,Arsenal,Title Race,Pronostic',
  2
),
(
  'Liga : Le Real Madrid peut-il rattraper le FC Barcelone ?',
  'La course au titre en Liga s\'annonce passionnante cette saison. Le FC Barcelone possede actuellement 5 points d\'avance sur le Real Madrid, mais les Merengues ont un match en retard qui pourrait changer la donne.\n\nLe Real Madrid traverse une periode de forme exceptionnelle depuis janvier. L\'equipe de Carlo Ancelotti a remporte 9 de ses 10 derniers matchs toutes competitions confondues. Vinicius Junior est en pleine forme avec 12 buts sur les 2 derniers mois.\n\nLe Barca, de son cote, a montre des signes de fragilite lors de ses derniers deplacements. Malgre une possession de balle dominante, les Catalans ont concede des buts evitables sur des contres rapides. Leur dependance envers certains joueurs cles commence a poser question.\n\nLe prochain Clasico sera evidemment le match a ne pas manquer. Le marche des paris offre actuellement une cote de 2.10 pour une victoire du Real Madrid au Bernabeu, ce qui represente une valeur interessante compte tenu de leur dynamique actuelle.\n\nNotre conseil : suivre l\'evolution des cotes dans les jours precedant le Clasico. Les mouvements du marche peuvent reveler des informations precieuses sur l\'etat de forme reel des equipes.',
  'Diego Ramirez',
  'Liga',
  'Analyse de la course au titre en Liga entre le Barca et le Real Madrid. Statistiques, forme et pronostics pour le Clasico.',
  '/image/liga.jpg',
  '2026-02-22',
  'Real Madrid,Barcelone,Clasico,Liga',
  3
),
(
  'Serie A : L\'Inter Milan en route vers un nouveau Scudetto ?',
  'L\'Inter Milan domine la Serie A de maniere impressionnante cette saison. Avec 10 points d\'avance sur la Juventus et 12 sur le Napoli, les Nerazzurri semblent se diriger vers un nouveau titre de champion d\'Italie.\n\nLes chiffres parlent d\'eux-memes : 58 buts marques (meilleure attaque), 15 buts concedes (meilleure defense), et une serie de 14 matchs sans defaite a domicile. Le duo Lautaro Martinez - Thuram fonctionne a merveille avec 28 buts combines.\n\nLa question pour les parieurs n\'est plus de savoir si l\'Inter sera champion, mais plutot comment exploiter les marches secondaires. Les cotes pour le titre sont desormais tres basses (1.15), mais il existe des opportunites interessantes.\n\nNous recommandons de se tourner vers les paris sur le nombre total de buts de l\'Inter sur la saison, ou sur les performances individuelles de Lautaro Martinez pour le titre de meilleur buteur. La cote de 2.80 pour Martinez buteur du championnat offre une excellente valeur.\n\nAttention toutefois a la Ligue des Champions. L\'historique montre que les equipes dominant leur championnat peuvent parfois relacher en fin de saison lorsque le titre est acquis.',
  'Marco Rosetti',
  'Serie A',
  'L\'Inter Milan survole la Serie A. Analyse de leur domination et opportunites de paris pour la fin de saison.',
  '/image/serie-a.jpg',
  '2026-02-18',
  'Inter Milan,Serie A,Scudetto,Martinez',
  4
),
(
  'Champions League : Les quarts de finale promettent du spectacle',
  'Le tirage au sort des quarts de finale de la Ligue des Champions a offert des affiches spectaculaires. Les 8 meilleures equipes d\'Europe vont s\'affronter pour une place dans le dernier carre de la competition.\n\nL\'affiche la plus attendue oppose le Real Madrid au Bayern Munich. Un classique du football europeen qui a toujours produit des matchs memorables. Le Real Madrid, detenteur du record de victoires en C1, affrontera un Bayern en pleine confiance apres avoir elimine Manchester City en 8emes.\n\nL\'autre affiche a suivre met aux prises le PSG et le FC Barcelone. Un remake des confrontations epiques des annees precedentes. Le PSG cherche toujours a remporter sa premiere Ligue des Champions, tandis que le Barca vise un retour au sommet europeen.\n\nPour les parieurs, les quarts de finale offrent generalement les meilleures opportunites de la saison. Les cotes sont plus equilibrees qu\'en phase de groupes, et les surprises ne sont pas rares. Nous recommandons particulierement le marche "qualifie" plutot que les matchs individuels.\n\nNos pronostics : Real Madrid qualifie (1.85), PSG qualifie (2.20), Liverpool qualifie (1.60), Inter Milan qualifie (1.75). Un combine de 2 ou 3 selections offre un excellent rapport risque/gain.',
  'Karim Benzali',
  'Champions League',
  'Analyse complete des quarts de finale de la Champions League. Affiches, favoris et pronostics pour chaque confrontation.',
  '/image/champions-league.jpg',
  '2026-02-15',
  'Champions League,Quarts de finale,Real Madrid,PSG',
  5
),
(
  'Bundesliga : Le Borussia Dortmund, outsider credible pour le titre ?',
  'La Bundesliga offre une saison passionnante avec le Borussia Dortmund qui revient dans la course au titre face au Bayern Munich. L\'ecart entre les deux equipes n\'est que de 3 points a 10 journees de la fin.\n\nLe BVB a considerablement renforce son effectif cette saison et les resultats suivent. Leur jeu offensif est l\'un des plus spectaculaires d\'Europe avec une moyenne de 2.5 buts par match. Le Signal Iduna Park reste une forteresse avec 100% de victoires a domicile.\n\nLe Bayern Munich, habituel champion, montre des signes inhabituels de vulnerabilite. Plusieurs defaites surprises contre des equipes du bas de tableau ont permis a Dortmund de revenir dans la course. La pression monte sur l\'entraineur munichois.\n\nD\'un point de vue paris sportifs, les prochaines confrontations directes seront determinantes. Le Klassiker (Bayern vs Dortmund) aura lieu le 15 mars, et les cotes actuelles reflettent un match tres equilibre : Bayern 2.20, Nul 3.40, Dortmund 3.10.\n\nNotre analyse suggere que Dortmund a une reelle chance de creer la surprise cette saison. Un pari a long terme sur le titre du BVB a 4.50 offre une valeur exceptionnelle pour les parieurs patients.',
  'Hans Muller',
  'Bundesliga',
  'Le Borussia Dortmund defie le Bayern Munich pour le titre en Bundesliga. Analyse statistique et cotes des paris.',
  '/image/bundesliga.jpg',
  '2026-02-12',
  'Dortmund,Bayern Munich,Bundesliga,Klassiker',
  6
);

INSERT INTO comments (article_id, author, content, date) VALUES
  (1, 'Julien D.',    'Excellente analyse ! Je suis d\'accord pour le 3-1, le PSG est trop fort cette saison.',    '2026-03-01'),
  (1, 'Mehdi K.',     'L\'OM peut creer la surprise, ne les sous-estimez pas dans les grands matchs.',             '2026-03-01'),
  (2, 'Tom W.',       'Liverpool a le meilleur effectif cette saison, je parie sur eux pour le titre.',            '2026-02-26'),
  (2, 'Claire B.',    'Le match contre Arsenal sera crucial. Hate d\'y etre !',                                    '2026-02-27'),
  (3, 'Pablo S.',     'Vinicius est intenable en ce moment, le Real va revenir.',                                  '2026-02-23'),
  (4, 'Giovanni L.',  'L\'Inter est clairement au-dessus cette saison. Bravo Inzaghi.',                            '2026-02-19'),
  (5, 'Youssef A.',   'PSG-Barca en quarts, ca va etre epique ! Je mise sur le PSG.',                             '2026-02-16'),
  (5, 'Emma R.',      'Real Madrid favori pour moi, leur experience en C1 fait la difference.',                    '2026-02-16'),
  (6, 'Felix H.',     'Enfin un vrai challenger pour le Bayern ! Allez Dortmund !',                               '2026-02-13');
