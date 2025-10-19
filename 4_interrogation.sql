/*Dans l'ensemble des requêtes suivantes vous retrouverez comme demandé 5 requêtes couvrant les différents types de requêtes vues en cours.
Certaines requêtes recouvrent plusieurs types*/

-- Liste des artistes Français et Américain
SELECT ID_Artiste, Nom_Scene, Nationalite
FROM Artiste
WHERE Nationalite IN ('Française', 'Américaine')
ORDER BY Nationalite, Nom_Scene;

-- Il y a t-il un DJ dans le label ? Liste des DJs du label
SELECT DISTINCT ID_Artiste , Nom_Scene
FROM Artiste
WHERE Nom_Scene LIKE '%DJ%'
ORDER BY Nom_Scene;

-- Liste des projets Pop ou Rock
SELECT ID_Projet, Titre_Projet, Genre_Musical
FROM Projet
WHERE Genre_Musical IN ('Pop', 'Rock')
ORDER BY Genre_Musical, Titre_Projet;

-- Classe les artistes par nombre de streams cumulés du plus écouté au moins écouté
SELECT a.ID_Artiste, a.Nom_Scene, SUM(eps.Nombre_Streams) AS Total_Streams
FROM Artiste a
JOIN travaillent_sur ts ON a.ID_Artiste = ts.ID_Artiste
JOIN est_publie_sur eps ON ts.ID_Projet = eps.ID_Projet
GROUP BY a.ID_Artiste, a.Nom_Scene
ORDER BY Total_Streams DESC;

-- Liste des artistes ayant un nombre de stream supérieur à la moyenne
SELECT a.ID_artiste, a.Nom_Scene, SUM(eps.Nombre_Streams) AS Total_Streams
FROM Artiste a
JOIN travaillent_sur ts ON a.ID_Artiste = ts.ID_Artiste
JOIN est_publie_sur eps ON ts.ID_Projet = eps.ID_Projet
GROUP BY a.Nom_Scene, a.ID_artiste
HAVING SUM(eps.Nombre_Streams) >(
  SELECT AVG(Nombre_Streams) FROM est_publie_sur
)
ORDER BY Total_Streams DESC;

-- Les artistes ayant gagné au moins une récompense
SELECT ID_Artiste, Nom_Scene
FROM Artiste
WHERE ID_Artiste IN (
    SELECT ts.ID_Artiste
    FROM travaillent_sur ts
    JOIN Récompense r ON ts.ID_Projet = r.ID_Projet
);

-- Classement de tous les artistes en fonction du nombre de récompenses différentes (pas deux Grammys par exemple)
SELECT a.ID_artiste ,a.Nom_Scene, COUNT(DISTINCT r.ID_Recompense) AS Nb_Recompenses
FROM Artiste a
LEFT JOIN travaillent_sur ts ON a.ID_Artiste = ts.ID_Artiste
LEFT JOIN Récompense r ON ts.ID_Projet = r.ID_Projet
GROUP BY a.Nom_Scene, a.ID_artiste
ORDER BY Nb_Recompenses DESC;

-- Les genres dont le budget moyen est supérieur à 800 000
SELECT p.Genre_Musical, AVG(p.Budget_Production) AS Budget_Moyen
FROM Projet p
GROUP BY p.Genre_Musical
HAVING AVG(p.Budget_Production) > 800000
ORDER BY Budget_Moyen DESC;

-- Tous les projets dont le budget est d'au moins 1 000 000
SELECT p.ID_Projet, p.Titre_Projet, p.Budget_Production
FROM Projet p
WHERE p.Budget_Production BETWEEN 1000000 AND (
  SELECT MAX(Budget_Production) FROM Projet
)
ORDER BY p.Budget_Production DESC;

-- Nom des Artiste à l'origine de projets dont le budget est supérieur ou égal au budget moyen de tous les projets classé 
SELECT DISTINCT a.Nom_Scene, p.Titre_Projet, p.Budget_Production
FROM Artiste a
JOIN travaillent_sur ts ON a.ID_Artiste = ts.ID_Artiste
JOIN Projet p ON ts.ID_Projet = p.ID_Projet
WHERE p.Budget_Production >= ALL(
  SELECT AVG(Budget_Production) FROM Projet
)
ORDER BY p.Budget_Production DESC;

-- Les artistes qui n'ont sorti AUCUN projet avant le 1er janvier 2020.
SELECT DISTINCT a.Nom_Scene
FROM Artiste a
WHERE NOT EXISTS (
    SELECT *
    FROM travaillent_sur ts
    JOIN Projet p ON ts.ID_Projet = p.ID_Projet
    WHERE ts.ID_Artiste = a.ID_Artiste
      AND p.Date_Sortie_Reelle < '2020-01-01'
)
ORDER BY a.Nom_Scene;

-- La liste des enregistrements et des studios dans lesquels ils ont été fait
SELECT e.Titre_Enregistrement, s.Nom_Studio
FROM Enregistrement e
INNER JOIN Studio s ON e.ID_Studio = s.ID_Studio;

-- Liste des studios du plus sollicités au moins
SELECT s.Nom_Studio, s.ID_Studio,COUNT(e.ID_Enregistrement) AS Nb_Enregistrements
FROM Studio s
LEFT JOIN Enregistrement e ON s.ID_Studio = e.ID_Studio
GROUP BY s.Nom_Studio, s.ID_Studio
ORDER BY Nb_Enregistrements DESC;

-- Projet dont la somme des streams dépasse TOUS les autres
SELECT eps.id_projet, SUM(eps.nombre_streams) AS total_streams
FROM est_publie_sur AS eps
GROUP BY eps.id_projet
HAVING SUM(eps.nombre_streams) >= ALL (
    SELECT SUM(nombre_streams)
    FROM est_publie_sur
    GROUP BY id_projet
);

-- classe les plateformes dont le nombre total de streams est strictement supérieur à la musique la plus streamée sur une plateforme 
SELECT pl.Nom_Plateforme, SUM(eps.Nombre_Streams) AS Streams_Platform
FROM Plateforme pl
JOIN est_publie_sur eps ON pl.ID_Plateforme = eps.ID_Plateforme
GROUP BY pl.Nom_Plateforme
HAVING SUM(eps.Nombre_Streams) > (
  SELECT MAX(Nombre_Streams) FROM est_publie_sur
)
ORDER BY Streams_Platform DESC;

-- Genres musicaux ayant un budget moyen n'étant pas le pire classé par ordre décroissant
SELECT p.Genre_Musical, AVG(p.Budget_Production) AS Moy_Budget
FROM Projet p
GROUP BY p.Genre_Musical
HAVING AVG(p.Budget_Production) > ANY (
    SELECT AVG(p2.Budget_Production)
    FROM Projet p2
    GROUP BY p2.Genre_Musical
)
ORDER BY Moy_Budget DESC;

-- Genres musicaux ayant plusieurs projets et faisant partie des catégories déjà récompensées.
SELECT p.Genre_Musical, COUNT(*) AS Nb_Projets
FROM Projet p
GROUP BY p.Genre_Musical
HAVING COUNT(*) > 2
   AND p.Genre_Musical IN (
        SELECT DISTINCT p2.Genre_Musical
        FROM Projet p2
        JOIN Récompense r ON p2.ID_Projet = r.ID_Projet
   );