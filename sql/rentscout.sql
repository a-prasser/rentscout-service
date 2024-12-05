-- 
-- This sql is for the rentscout app
-- @author Theo Perumal
-- Fall 2024

DROP TABLE IF EXISTS Property;
DROP TABLE IF EXISTS Game;
DROP TABLE IF EXISTS Player;


CREATE TABLE Property (
    ID SERIAL PRIMARY KEY,
    Price integer,
    proximityToCalvin integer, 
    bedroomNum integer,
    bathNum FLOAT, 
    streetAddress varchar(100),
    accessibility varchar(100)
);

CREATE TABLE Landlord ( 
    ID SERIAL PRIMARY KEY,
    Website varchar(100),
    phoneNumber varchar(15), 
    numProperties integer,
    name varchar(100)
);

CREATE TABLE Student (
    ID SERIAL PRIMARY KEY,
    priceCap integer, 
    distanceCap integer, 
    name varchar(100)
);

CREATE TABLE PropertyLandlord (
    propertyID integer REFERENCES Property(ID), 
    landlordID integer REFERENCES Landlord(ID)
);

GRANT SELECT ON Property TO PUBLIC;
GRANT SELECT ON Landlord TO PUBLIC;
GRANT SELECT ON Student TO PUBLIC;
GRANT SELECT ON PropertyLandlord TO PUBLIC;

INSERT INTO Property VALUES (1, 2000, 2, 4, 2, '2008 Edgewood Ave SE, Grand Rapids MI, 49546', 'NA' );
INSERT INTO Property Values (2, 2200, 10, 5, 2.5, '1610 Rossman Ave, Grand Rapids MI, 49507', 'NA');

INSERT INTO Landlord VALUES (1, 'NA', 1234567890, 8, 'Erik Kraayveld');

INSERT INTO Student (1, 2000, 5, 'Theo');

INSERT INTO PropertyLandlord (2, 1);