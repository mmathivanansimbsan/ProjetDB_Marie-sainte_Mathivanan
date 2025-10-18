USE labeldb;

# TABLE : Adresse
ALTER TABLE Adresse
	ADD CONSTRAINT `chk_Code_Postale_Coherent`
	CHECK (`Code_Postal` BETWEEN 01000 AND 99000);


# TABLE : Artiste
ALTER TABLE Artiste
	ADD CONSTRAINT `chk_nationalité_valide`
	CHECK (
		`Nationalite` IN (
			'Afghane','Albanaise','Algérienne','Américaine','Andorrane','Angolaise','Argentine','Arménienne','Australienne','Autrichienne','Azerbaïdjanaise',
			'Bahamienne','Bahreïnienne','Bangladaise','Barbadienne','Biélorusse','Belge','Bélizienne','Béninoise','Bhoutanaise','Bolivienne','Bosniaque',
			'Brésilienne','Britannique','Brunienne','Bulgare','Burkinabée','Birmane','Burundaise','Cambodgienne','Camerounaise','Canadienne','Cap-verdienne',
			'Centre-africaine','Tchadienne','Chilienne','Chinoise','Colombienne','Comorienne','Congolaise','Costaricaine','Croate','Cubaine','Chypriote',
			'Tchèque','Danoise','Djiboutienne','Dominicaine','Néerlandaise','Écossaise','Égyptienne','Émirienne','Équatorienne','Érythréenne','Estonienne',
			'Éthiopienne','Fidjienne','Finlandaise','Française','Gabonaise','Gambienne','Géorgienne','Allemande','Ghanéenne','Grecque','Grenadienne',
			'Guatémaltèque','Guinéenne','Guyanienne','Haïtienne','Hondurienne','Hongroise','Indienne','Indonésienne','Iranienne','Irakienne','Irlandaise',
			'Israélienne','Italienne','Ivoirienne','Jamaïcaine','Japonaise','Jordanaise','Kazakhstanaise','Kényane','Kiribatienne','Koweïtienne','Kirghize',
			'Laotienne','Lettonne','Libanaise','Libérienne','Libyenne','Liechtensteinoise','Lituanienne','Luxembourgeoise','Macédonienne','Malgache',
			'Malawienne','Malaisienne','Maldivienne','Malienne','Maltaise','Marshallienne','Mauritanienne','Mauricienne','Mexicaine','Micronésienne','Moldave',
			'Monégasque','Mongole','Marocaine','Mozambicaine','Namibienne','Nauruane','Népalaise','Néo-zélandaise','Nicaraguayenne','Nigérienne','Nigériane',
			'Norvégienne','Omanaise','Pakistanaise','Palauane','Panaméenne','Papouane-nouvelle-guinéenne','Paraguayenne','Péruvienne','Polonaise','Portugaise',
			'Qatarienne','Roumaine','Russe','Rwandaise','Saint-lucienne','Salvadorienne','Samoane','Saint-marinaise','Saotoméenne','Saoudienne','Écossaise',
			'Sénégalaise','Serbe','Seychelloise','Sierraléonaise','Singapourienne','Slovaque','Slovène','Salomonaise','Somalienne','Sud-africaine',
			'Sud-coréenne','Espagnole','Srilankaise','Soudanaise','Surinamaise','Swazie','Suédoise','Suisse','Syrienne','Taïwanaise','Tadjikiste','Tanzanienne',
			'Thaïlandaise','Togolaise','Tongienne','Trinidadienne ou Tobagonienne','Tunisienne','Turque','Tuvaluane','Ugandaise','Ukrainienne','Uruguayenne',
			'Ouzbékiste','Vénézuélienne','Vietnamienne','Galloise','Yéménite','Zambienne','Zimbabwéenne'
		)
	);


# TABLE : Contrat
ALTER TABLE Contrat
	ADD CONSTRAINT `chk_Avance_Contrat_Positif`
	CHECK (`Avance_Contrat` > 0),
	ADD CONSTRAINT `chk_Date_Contrat_Coherente`
	CHECK (`Date_Fin_Contrat` IS NULL OR `Date_Fin_Contrat` > `Date_Debut_Contrat`),
	ADD CONSTRAINT `chk_Pourcentage_Redevence_Coherent`
	CHECK (`Pourcentage_Redevance` IS NULL OR (`Pourcentage_Redevance` BETWEEN 0 AND 100));

# TABLE : Enregistrement
ALTER TABLE Enregistrement
	ADD CONSTRAINT `chk_Durée_Enregistrement_Coherente`
	CHECK (`Duree_Enregistrement` > 0),
	ADD CONSTRAINT `chk_Genre_Musical_Enregistrement_valide`
	CHECK (`Genre_musical` IN ('Pop','Rock','Rap','R&B','Electro','Jazz','Classique','Reggae','Country','Latin','Soul','Alternative','Metal','Autres'));


# TABLE : est_publie_sur
ALTER TABLE est_publie_sur
	ADD CONSTRAINT `chk_Nombre_De_Stream_Positif`
	CHECK (`Nombre_Streams` > 0);


# TABLE : Plateforme
ALTER TABLE Plateforme
	ADD CONSTRAINT `chk_Plateforme_de_Streaming_valide`
	CHECK (`Nom_Plateforme` IN ('Spotify','Apple_music','Deezer','Youtube_Music','Amazon_music','Tidal','Qobuz','Soundcloud'));

# TABLE : Projet
ALTER TABLE Projet
	ADD CONSTRAINT `chk_Budget_Positif`
	CHECK (`Budget_Production` > 0),
	ADD CONSTRAINT `chk_Date_Projet_Coherente`
	CHECK (`Date_Sortie_Reelle` IS NULL OR `Date_Sortie_Reelle` >= `Date_Sortie_Prevue`),
	ADD CONSTRAINT `chk_Genre_Musical__Projet_valide`
	CHECK (`Genre_musical` IN ('Pop','Rock','Rap','R&B','Electro','Jazz','Classique','Reggae','Country','Latin','Soul','Alternative','Metal','Autres'));

# TABLE : Recompense
ALTER TABLE Récompense
	ADD CONSTRAINT `chk_Annee_Recompense_Coherente` CHECK (`Annee_Recompense` < 2026);

    
    
    
    
    
    