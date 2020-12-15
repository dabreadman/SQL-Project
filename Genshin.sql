CREATE DATABASE IF NOT EXISTS Genshin;
USE Genshin;

# Create tables 
CREATE TABLE Elements (
    element_id INT NOT NULL UNIQUE AUTO_INCREMENT,
    element_name VARCHAR(25) NOT NULL UNIQUE,
    element_effect VARCHAR(50) NOT NULL,
    PRIMARY KEY (element_id)
);

CREATE TABLE Weapon_types (
    wt_id INT NOT NULL UNIQUE AUTO_INCREMENT,
    wt_name VARCHAR(25) NOT NULL UNIQUE,
    PRIMARY KEY (wt_id)
);

CREATE TABLE Weapons (
    weapon_id INT NOT NULL UNIQUE AUTO_INCREMENT,
    weapon_name VARCHAR(25) NOT NULL UNIQUE,
    weapon_type INT NOT NULL,
    weapon_damage INT NOT NULL,
    PRIMARY KEY (weapon_id),
    FOREIGN KEY (weapon_type)
        REFERENCES Weapon_types (wt_id) ON DELETE CASCADE,
    CHECK (weapon_damage > 0)
);

CREATE TABLE Forge (
    craft_id INT NOT NULL UNIQUE AUTO_INCREMENT,
    craft_item INT NOT NULL UNIQUE,
    craft_mora_cost INT DEFAULT 0,
    craft_success_chance INT DEFAULT 0,
    PRIMARY KEY (craft_id),
    FOREIGN KEY (craft_item)
        REFERENCES Weapons (weapon_id) ON DELETE CASCADE,
    CHECK (craft_success_chance BETWEEN 0 AND 100)
);

CREATE TABLE Artefact_types (
    arty_id INT NOT NULL UNIQUE AUTO_INCREMENT,
    arty_name VARCHAR(25) NOT NULL UNIQUE,
    PRIMARY KEY (arty_id)
);

CREATE TABLE Artefacts (
    art_id INT NOT NULL UNIQUE AUTO_INCREMENT,
    art_name VARCHAR(25) NOT NULL UNIQUE,
    art_type INT NOT NULL,
    art_damage INT NOT NULL,
    PRIMARY KEY (art_id),
    FOREIGN KEY (art_type)
        REFERENCES Artefact_types (arty_id) ON DELETE CASCADE,
    CHECK (art_damage > 0)
);

CREATE TABLE Domains (
    domain_id INT NOT NULL UNIQUE AUTO_INCREMENT,
    domain_name VARCHAR(25) NOT NULL UNIQUE,
    domain_item_drop INT,
    domain_mora_drop INT DEFAULT 0,
    domain_drop_chance INT DEFAULT 0,
    PRIMARY KEY (domain_id),
    FOREIGN KEY (domain_item_drop)
        REFERENCES Artefacts (art_id) ON DELETE CASCADE,
    CHECK (domain_drop_chance BETWEEN 0 AND 100)
);

CREATE TABLE Characters (
    char_id INT NOT NULL UNIQUE AUTO_INCREMENT,
    char_name VARCHAR(25) NOT NULL UNIQUE,
    char_damage INT NOT NULL,
    char_element INT,
    char_weapon_type INT NOT NULL,
    char_art_type INT NOT NULL,
    PRIMARY KEY (char_id),
    FOREIGN KEY (char_element)
        REFERENCES Elements (element_id) ON DELETE SET NULL,
    FOREIGN KEY (char_weapon_type)
        REFERENCES Weapon_types (wt_id) ON DELETE CASCADE,
    FOREIGN KEY (char_art_type)
        REFERENCES Artefact_types (arty_id) ON DELETE CASCADE,
    CHECK (char_damage > 0)
);

CREATE TABLE Players (
    player_id INT NOT NULL UNIQUE AUTO_INCREMENT,
    player_name VARCHAR(25) UNIQUE NOT NULL,
    player_mora INT DEFAULT 0,
    player_character INT,
    player_weapon INT,
    player_artefact INT,
    PRIMARY KEY (player_id),
    FOREIGN KEY (player_character)
        REFERENCES Characters (char_id) ON DELETE SET NULL,
    FOREIGN KEY (player_weapon)
        REFERENCES Weapons (weapon_id) ON DELETE SET NULL,
    FOREIGN KEY (player_artefact)
        REFERENCES Artefacts (art_id) ON DELETE SET NULL,
    CHECK (player_mora >= 0)
);

# Create trigger
# Add numerical suffix to duplicated player_name
DELIMITER //
CREATE TRIGGER change_player_name 
	BEFORE INSERT ON Players
	FOR EACH ROW 
BEGIN
	DECLARE original_player_name VARCHAR(25);
	DECLARE suffix_counter INT;
	SET original_player_name = NEW.player_name;
	SET suffix_counter = 1;
	WHILE EXISTS (SELECT TRUE FROM Players WHERE player_name = NEW.player_name) DO
		SET NEW.player_name = concat(original_player_name, suffix_counter); 
		SET suffix_counter = suffix_counter + 1;
	END WHILE;
END 
//

# Insert tuples
INSERT INTO Elements 
VALUES (DEFAULT,'Pyro','Applies Burning'),
(DEFAULT,'Hyro','Slows enemies'),
(DEFAULT,'Dendro','Applies flamable'),
(DEFAULT,'Anemo','Spreads elemental effects'),
(DEFAULT,'Elctro','Paralyses enemies'),
(DEFAULT,'Geo','Creates shields');

INSERT INTO Weapon_types
VALUES (DEFAULT,'Claymore'),(DEFAULT,'Bow'),(DEFAULT,'Sword'),(DEFAULT,'Catalyst'),(DEFAULT,'Polearm');

INSERT INTO Weapons
VALUES 
(DEFAULT,'Skyrider Claymore',1,30),(DEFAULT,'Sacrificial Claymore',1,40),(DEFAULT,'Claymore Prime',1,50),
(DEFAULT,'Skyrider Bow',2,30),(DEFAULT,'Sacrificial Bow',2,40),(DEFAULT,'Bow Prime',2,50),
(DEFAULT,'Skyrider Sword',3,30),(DEFAULT,'Sacrificial Sword',3,40),(DEFAULT,'Sword Prime',3,50),
(DEFAULT,'Skyrider Catalyst',4,30),(DEFAULT,'Sacrificial Catalyst',4,40),(DEFAULT,'Catalyst Prime',4,50),
(DEFAULT,'Skyrider Polearm',5,30),(DEFAULT,'Sacrificial Polearm',5,40),(DEFAULT,'Polearm Prime',5,60);

INSERT INTO Forge
VALUES
(DEFAULT,1,530,50),(DEFAULT,2,1200,30),(DEFAULT,3,1700,20),
(DEFAULT,4,510,42),(DEFAULT,5,1030,31),(DEFAULT,6,1800,25),
(DEFAULT,7,550,40),(DEFAULT,8,1070,37),(DEFAULT,9,1850,20),
(DEFAULT,10,570,52),(DEFAULT,11,1300,32),(DEFAULT,12,1500,24),
(DEFAULT,13,530,53),(DEFAULT,14,1020,33),(DEFAULT,15,1900,23);

INSERT INTO Artefact_types
VALUES (DEFAULT,'Blessing'),(DEFAULT,'Charm'),(DEFAULT,'Obession');

INSERT INTO Artefacts
VALUES 
(DEFAULT,'Hunter\'s Blessing',1,30),(DEFAULT,'Warden\'s Blessing',1,40),(DEFAULT,'Cursed Blessing',1,50),
(DEFAULT,'Hunter\'s Charm',2,30),(DEFAULT,'Warden\'s Charm',2,40),(DEFAULT,'Cursed Charm',2,50),
(DEFAULT,'Hunter\'s Obession',3,30),(DEFAULT,'Warden\'s Obession',3,40),(DEFAULT,'Cursed Obession',3,50);

INSERT INTO Domains
VALUES
(DEFAULT,'Dragon\'s Den',null,1000,0),
(DEFAULT,'Hunter\'s Altar',1,0,50),(DEFAULT,'Warden\'s Altar',2,-100,30),(DEFAULT,'Cursed Altar',3,-1000,30),
(DEFAULT,'Hunter\'s Treasury',4,0,40),(DEFAULT,'Warden\'s Treasury',5,-150,35),(DEFAULT,'Cursed Treasury',6,-1200,35),
(DEFAULT,'Hunter\'s Husk',7,0,45),(DEFAULT,'Warden\'s Husk',8,-250,35),(DEFAULT,'Cursed Husk',9,0,5);

INSERT INTO Characters
VALUES 
(DEFAULT,'Diluc',60,1,1,2),
(DEFAULT,'Xinyan',40,1,1,1),
(DEFAULT,'Razor',40,5,1,2),
(DEFAULT,'Sucrose',40,4,4,3),
(DEFAULT,'Zhongli',60,6,5,1),
(DEFAULT,'Slimy',30,3,3,3),
(DEFAULT,'Traveller',60,null,3,1),
(DEFAULT,'Childe',60,2,2,3),
(DEFAULT,'Fischl',40,4,2,1);

INSERT INTO Players
VALUES 
(DEFAULT,'xcalibur2',0,null,null,null),
(DEFAULT,'dilucmain',670,1,3,5),
(DEFAULT,'electrojojo',400,3,1,5),
(DEFAULT,'chu2ni',2820,9,5,3),
(DEFAULT,'bigdaddy33',0,5,15,2),
(DEFAULT,'slime4life',44,6,9,9),
(DEFAULT,'unarmedman666',6600,7,null,9);

# Create views
# Provides a quick overview to each players' state.
CREATE VIEW Quickview AS
	SELECT 
		p.player_id AS 'Player ID',
		p.player_name AS 'Player Name',
        p.player_mora AS 'Mora Remaining',
        c.char_name AS 'Character',
        w.weapon_name AS 'Equiped Weapon',
        a.art_name AS 'Equiped Artefact'
    FROM Players p
    LEFT JOIN
        Artefacts a ON p.player_artefact = a.art_id
	LEFT JOIN
        Weapons w ON p.player_weapon = w.weapon_id
	LEFT JOIN
        Characters c ON p.player_character = c.char_id;

# Provides a recommendations for each player based on their selected character.
CREATE VIEW Build_recommendations AS
    SELECT 
		p.player_id AS 'Player ID',
		p.player_name AS 'Player Name',
        c.char_name AS 'Character',
		w.weapon_name  AS 'Equiped Weapon',
        a.art_name AS 'Equiped Artefact',
        CASE WHEN c.char_id is NULL THEN 0 
			ELSE COALESCE(w.weapon_damage,0) + COALESCE(a.art_damage,0) + COALESCE(c.char_damage,0) END AS 'Total Damage',
        recommended_weap.weapon_name 'Recommended Weapon',
        recommended_art.art_name ' Recommended Artefact',
        CASE WHEN c.char_id is NULL THEN NULL 
			ELSE COALESCE(recommended_weap.max_weapon_damage,0)+COALESCE(recommended_art.max_art_damage,0)+COALESCE(c.char_damage,0) END AS 'BiS Damage'
    FROM
        Players p
	LEFT JOIN
        Artefacts a ON p.player_artefact = a.art_id
	LEFT JOIN
        Weapons w ON p.player_weapon = w.weapon_id
	LEFT JOIN
        Characters c ON p.player_character = c.char_id
	LEFT JOIN
        (SELECT 
            w.weapon_name,
                best_weapon_by_type.max_weapon_damage,
                w.weapon_type
        FROM
            Weapons w
        JOIN (
			SELECT 
				MAX(weapon_damage) max_weapon_damage, weapon_type
			FROM
				Weapons
			GROUP BY weapon_type
            ) best_weapon_by_type 
			ON best_weapon_by_type.max_weapon_damage = w.weapon_damage
				AND best_weapon_by_type.weapon_type = w.weapon_type
		) recommended_weap 
		ON c.char_weapon_type = recommended_weap.weapon_type
	LEFT JOIN
        (SELECT 
            art.art_name,
			best_art_by_type.max_art_damage,
			art.art_type
        FROM
            Artefacts art
        JOIN (
			SELECT 
				MAX(art_damage) max_art_damage, art_type
			FROM
				Artefacts
			GROUP BY art_type
            ) best_art_by_type 
			ON best_art_by_type.max_art_damage = art.art_damage
				AND best_art_by_type.art_type = art.art_type
		) recommended_art 
		ON c.char_art_type = recommended_art.art_type;
        
# Create roles
# Dbmaster has complete control of the database.
CREATE ROLE Dbmaster;
GRANT ALL PRIVILEGES ON * TO Dbmaster WITH GRANT OPTION;

# Developer has access to every tables. 
CREATE ROLE Developer;
GRANT ALL PRIVILEGES ON * TO Developer;

# Gamemaster has full access to both views and SELECT privileges on all other tables.
CREATE ROLE Gamemaster;
GRANT SELECT ON * TO Gamemaster;
GRANT ALL PRIVILEGES ON Quickview TO Gamemaster;
GRANT ALL PRIVILEGES ON Build_recommendations TO Gamemaster;

# Player has SELECT access to all tables.
CREATE ROLE Player;
GRANT SELECT ON * TO Player;



