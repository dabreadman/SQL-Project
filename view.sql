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
        


	