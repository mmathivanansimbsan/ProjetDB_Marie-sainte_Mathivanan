create schema labeldb;
use labeldb;

CREATE TABLE Plateforme(
   ID_Plateforme INT,
   Nom_Plateforme VARCHAR(50),
   Date_Mise_en_ligne DATE,
   PRIMARY KEY(ID_Plateforme)
);

CREATE TABLE Personnel(
   ID_Personnel INT,
   Prénom_Personnel VARCHAR(50),
   Nom_Personnel VARCHAR(100),
   Fonction_Personnel VARCHAR(50),
   ID_Personnel_Manager INT,
   PRIMARY KEY(ID_Personnel),
   FOREIGN KEY(ID_Personnel_Manager) REFERENCES Personnel(ID_Personnel)
);

CREATE TABLE Projet(
   ID_Projet INT,
   Titre_Projet VARCHAR(150),
   Type_Projet VARCHAR(20),
   Genre_Musical VARCHAR(50),
   Budget_Production DECIMAL(12,2),
   Date_sortie_Prevue DATE,
   Date_Sortie_Reelle DATE,
   PRIMARY KEY(ID_Projet)
);

CREATE TABLE Contrat(
   ID_Contrat INT,
   Date_Debut_Contrat DATE,
   Date_Fin_Contrat DATE,
   Avance_Contrat DECIMAL(12,2),
   Pourcentage_Redevance DECIMAL(3,3),
   PRIMARY KEY(ID_Contrat)
);

CREATE TABLE Equipe(
   ID_Equipe INT,
   PRIMARY KEY(ID_Equipe)
);

CREATE TABLE Adresse(
   ID_Addresse INT,
   Numéro_Rue VARCHAR(50),
   Nom_Rue VARCHAR(50),
   Appartement VARCHAR(50),
   Code_Postal VARCHAR(50),
   PRIMARY KEY(ID_Addresse)
);

CREATE TABLE Studio(
   ID_Studio INT,
   Nom_Studio VARCHAR(100),
   ID_Addresse INT NOT NULL,
   PRIMARY KEY(ID_Studio),
   FOREIGN KEY(ID_Addresse) REFERENCES Adresse(ID_Addresse)
);

CREATE TABLE Groupe(
   ID_Groupe INT,
   Nom_Groupe VARCHAR(100),
   PRIMARY KEY(ID_Groupe)
);

CREATE TABLE Récompense(
   ID_Recompense INT,
   Nom_Recompense VARCHAR(100),
   Annee_Recompense INT,
   ID_Projet INT NOT NULL,
   PRIMARY KEY(ID_Recompense),
   FOREIGN KEY(ID_Projet) REFERENCES Projet(ID_Projet)
);

CREATE TABLE Artiste(
   ID_Artiste INT,
   Nom_Scene VARCHAR(100),
   Biographie VARCHAR(2000),
   Nationalite VARCHAR(50),
   ID_Groupe INT,
   PRIMARY KEY(ID_Artiste),
   FOREIGN KEY(ID_Groupe) REFERENCES Groupe(ID_Groupe)
);

CREATE TABLE Enregistrement(
   ID_Enregistrement INT,
   Titre_Enregistrement VARCHAR(150),
   Genre_Musical VARCHAR(50),
   Duree_Enregistrement SMALLINT,
   Date_Enregistrement DATE,
   ID_Studio INT NOT NULL,
   PRIMARY KEY(ID_Enregistrement),
   FOREIGN KEY(ID_Studio) REFERENCES Studio(ID_Studio)
);

CREATE TABLE Contact(
   ID_Artiste INT,
   ID_Contact INT,
   Type_Contact VARCHAR(50),
   Coordonnees_Contact VARCHAR(100),
   PRIMARY KEY(ID_Artiste, ID_Contact),
   FOREIGN KEY(ID_Artiste) REFERENCES Artiste(ID_Artiste)
);

CREATE TABLE travaille_dans(
   ID_Personnel INT,
   ID_Equipe INT,
   PRIMARY KEY(ID_Personnel, ID_Equipe),
   FOREIGN KEY(ID_Personnel) REFERENCES Personnel(ID_Personnel),
   FOREIGN KEY(ID_Equipe) REFERENCES Equipe(ID_Equipe)
);

CREATE TABLE signe(
   ID_Artiste INT,
   ID_Contrat INT,
   PRIMARY KEY(ID_Artiste, ID_Contrat),
   FOREIGN KEY(ID_Artiste) REFERENCES Artiste(ID_Artiste),
   FOREIGN KEY(ID_Contrat) REFERENCES Contrat(ID_Contrat)
);

CREATE TABLE est_publie_sur(
   ID_Plateforme INT,
   ID_Projet INT,
   Nombre_Streams INT,
   PRIMARY KEY(ID_Plateforme, ID_Projet),
   FOREIGN KEY(ID_Plateforme) REFERENCES Plateforme(ID_Plateforme),
   FOREIGN KEY(ID_Projet) REFERENCES Projet(ID_Projet)
);

CREATE TABLE travaillent_sur(
   ID_Artiste INT,
   ID_Projet INT,
   ID_Equipe INT,
   PRIMARY KEY(ID_Artiste, ID_Projet, ID_Equipe),
   FOREIGN KEY(ID_Artiste) REFERENCES Artiste(ID_Artiste),
   FOREIGN KEY(ID_Projet) REFERENCES Projet(ID_Projet),
   FOREIGN KEY(ID_Equipe) REFERENCES Equipe(ID_Equipe)
);

CREATE TABLE est_compose_de(
   ID_Projet INT,
   ID_Enregistrement INT,
   PRIMARY KEY(ID_Projet, ID_Enregistrement),
   FOREIGN KEY(ID_Projet) REFERENCES Projet(ID_Projet),
   FOREIGN KEY(ID_Enregistrement) REFERENCES Enregistrement(ID_Enregistrement)
);

