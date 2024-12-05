--
-- This SQL script is built on the schema from the previous script, but it adds
-- more tables in order to hold the state of players during an active game
--
-- @author jtlun
--

-- Drop previous versions of the tables if they they exist, in reverse order of foreign keys.
DROP TABLE IF EXISTS Property;
DROP TABLE IF EXISTS PlayerGame;
DROP TABLE IF EXISTS Game;
DROP TABLE IF EXISTS Player;

-- Create the schema.
CREATE TABLE Game (
	ID integer PRIMARY KEY,
	time timestamp
	);

CREATE TABLE Player (
	ID integer PRIMARY KEY, 
	emailAddress varchar(50) NOT NULL,
	name varchar(50)
	);

CREATE TABLE PlayerGame (
	ID integer PRIMARY KEY,
	gameID integer REFERENCES Game(ID), 
	playerID integer REFERENCES Player(ID),
	score integer,
  cash integer,
  pieceLocation integer
	);

-- Add a table to hold the properties that players own.
-- Note: 5 houses = hotel via the rules of Monopoly.
CREATE TABLE Property (
  ID integer PRIMARY KEY,
  playerGameID integer REFERENCES PlayerGame(ID),
  name varchar(50),
  houses integer
  );

-- Allow users to select data from the tables.
GRANT SELECT ON Game TO PUBLIC;
GRANT SELECT ON Player TO PUBLIC;
GRANT SELECT ON PlayerGame TO PUBLIC;
GRANT SELECT ON Property TO PUBLIC;

-- Add sample records.
INSERT INTO Game VALUES (1, '2006-06-27 08:00:00');
INSERT INTO Game VALUES (2, '2006-06-28 13:20:00');
INSERT INTO Game VALUES (3, '2006-06-29 18:41:00');

INSERT INTO Player(ID, emailAddress) VALUES (1, 'me@calvin.edu');
INSERT INTO Player VALUES (2, 'king@gmail.edu', 'The King');
INSERT INTO Player VALUES (3, 'dog@gmail.edu', 'Dogbreath');

INSERT INTO PlayerGame VALUES (1, 1, 1, 0.00, 100, 0);
INSERT INTO PlayerGame VALUES (2, 1, 2, 0.00, 1234, 3);
INSERT INTO PlayerGame VALUES (3, 1, 3, 2350.00, 12342, 15);
INSERT INTO PlayerGame VALUES (4, 2, 1, 1000.00, 572, 28);
INSERT INTO PlayerGame VALUES (5, 2, 2, 0.00, 87, 16);
INSERT INTO PlayerGame VALUES (6, 2, 3, 500.00, 872, 17);
INSERT INTO PlayerGame VALUES (7, 3, 2, 0.00, 1503, 39);
INSERT INTO PlayerGame VALUES (8, 3, 3, 5500.00, 1234, 1);

INSERT INTO Property VALUES (1, 1, 'Boardwalk', 0);
INSERT INTO Property VALUES (2, 1, 'Park Place', 0);
INSERT INTO Property VALUES (3, 2, 'Baltic Avenue', 0);
INSERT INTO Property VALUES (4, 3, 'Reading Railroad', 0);
INSERT INTO Property VALUES (5, 3, 'Pennsylvania Railroad', 0);
INSERT INTO Property VALUES (6, 3, 'B&O Railroad', 0);
INSERT INTO Property VALUES (7, 3, 'Short Line', 0);
INSERT INTO Property VALUES (8, 3, 'Electric Company', 1);
INSERT INTO Property VALUES (9, 3, 'Water Works', 0);
INSERT INTO Property VALUES (10, 3, 'Marvin Gardens', 5);
INSERT INTO Property VALUES (11, 3, 'Ventnor Avenue', 3);
INSERT INTO Property VALUES (12, 3, 'Atlantic Avenue', 1);
INSERT INTO Property VALUES (13, 3, 'Illinois Avenue', 2);