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
