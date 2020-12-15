create database IF NOT EXISts dbtemp;
use dbtemp;

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

  


