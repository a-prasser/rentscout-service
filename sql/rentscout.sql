-- 
-- This sql is for the rentscout app
-- @author Theo Perumal
-- edited and updated by Jonathan Lundberg
-- Fall 2024

-- several pieces of data in this database are incorrect and merely for demonstration purposes
-- this includes:
-- property pet friendly status and rating
-- landlord phones, emails, and websites
-- student names and emails

-- Drop old Monopoly tables if they exist
-- These can be removed once this file has been run once
DROP TABLE IF EXISTS Property;
DROP TABLE IF EXISTS PlayerGame;
DROP TABLE IF EXISTS Game;
DROP TABLE IF EXISTS Player;

-- Drop outdated RentScout tables if they exist

DROP TABLE IF EXISTS Rview;
DROP TABLE IF EXISTS Property;
DROP TABLE IF EXISTS Landlord;
DROP TABLE IF EXISTS Student;

CREATE TABLE Student (
    ID SERIAL PRIMARY KEY,
    name varchar(100),
    email varchar(255)
);

CREATE TABLE Landlord ( 
    ID SERIAL PRIMARY KEY,
    name varchar(100),
    Website varchar(100),
    phoneNumber varchar(15),
    emailAddress varchar(255)
);

CREATE TABLE Property (
    ID SERIAL PRIMARY KEY,
    landlordID integer REFERENCES Landlord(ID),
    bannerImage varchar(100),
    streetAddress varchar(100),
    bedroomNum integer,
    bathroomNum FLOAT,
    price integer,
    distanceToCalvin FLOAT,
    distanceToBusStop FLOAT,
    petFriendly BOOLEAN,
    rating FLOAT
);

CREATE TABLE Review (
    studentID integer REFERENCES Student(ID),
    propertyID integer REFERENCES Property(ID),
    rating FLOAT,
    reviewText varchar(2047)
);

GRANT SELECT ON Student TO PUBLIC;
GRANT SELECT ON Landlord TO PUBLIC;
GRANT SELECT ON Property TO PUBLIC;
GRANT SELECT ON Review TO PUBLIC;

INSERT INTO Student VALUES (1, 'Theo', 'fake_email@calvin.edu');
INSERT INTO Student VALUES (2, 'Jonathan', 'fake_email_2@calvin.edu');

INSERT INTO Landlord VALUES (1, 'Erik Kraayeveld', 'https://www.kraayeveldproperties.com/', '616-123-4567', 'contact@kraayeveldproperties.com');
INSERT INTO Landlord VALUES (2, 'Cathy Sevigny', null, null, null);
INSERT INTO Landlord VALUES (3, 'Continental Properties Co', 'continentalProperties.org', '616-123-4567', 'contact@contentialProperties.org');
INSERT INTO Landlord VALUES (4, 'Brian Tagg', null, '616-987-6543', 'btagg@yahoo.com');
INSERT INTO Landlord VALUES (5, 'Shift Management LLC', null, null, null);
INSERT INTO Landlord VALUES (6, 'Aiesha Reynolds', null, '616-555-5555', 'aieshareynolds@outlook.com');
INSERT INTO Landlord VALUES (7, 'HCW Realty', null, null, null);
INSERT INTO Landlord VALUES (8, 'Rental Properties Consultant LLC', null, null, null);

INSERT INTO Property VALUES (1, 1, null, '1610 Rossman Ave, Grand Rapids MI, 49507', 5, 2.5, 2200, 2.2, 0.6, true, 4.5);
INSERT INTO Property VALUES (2, 1, null, '1024 Burton St SE, Grand Rapids, MI 49507', 4, 2, 1750, 2.8, 0.3, false, 4.0);
INSERT INTO Property VALUES (3, 1, null, '1421 Sherman St SE, Grand Rapids, MI 49506', 5, 2, 2000, 2.8, 0.4, false, 4.0);
INSERT INTO Property VALUES (4, 1, null, '249 Alger St SE, Grand Rapids, MI 49507', 5, 2, 1950, 3.8, 0.3, false, 2.4);
INSERT INTO Property VALUES (5, 1, null, '1314 Boston St SE, Grand Rapids, MI 40507', 4, 2, 1700, 2.5, 0.2, true, 3.5);
INSERT INTO Property VALUES (6, 2, null, '118 National Ave SW, Grand Rapids, MI 49504', 2, 1, 1475, 5.4, 0.2, true, 3.0);
INSERT INTO Property VALUES (7, 3, null, '2010 Deciduous Dr, Grand Rapids MI 49505', 2, 3, 2280, 4.8, 0.7, false, 4.9);
INSERT INTO Property VALUES (8, 4, null, '2142 Stafford Ave SW, Grand Rapids, MI 49507', 3, 1, 2000, 4.5, 0.3, true, 3.4);
INSERT INTO Property VALUES (9, 4, null, '3476 Bluebird Ave SW, Wyoming MI, 49519', 3, 1, 2100, 7.4, 0.3, false, 4.8);
INSERT INTO Property VALUES (10, 5, null, '1126 Merrifield St SE, Grand Rapids, MI 49507', 4, 1, 1895, 2.7, 0.2, false, 4.7);
INSERT INTO Property VALUES (11, 6, null, '636 Innes St NE, Grand Rapids, MI 49503', 2, 1, 1000, 4.2, 0.4, true, 3.9);
INSERT INTO Property VALUES (12, 7, null, '471 Emerald Ave NE, Grand Rapids, MI 49503', 4, 1, 1900, 4.2, 0.2, false, 4.2);
INSERT INTO Property VALUES (13, 8, null, '1020 Sigsbee St SE, Grand Rapids, MI 49506', 5, 2, 3200, 3.3, 0.1, true, 4.6);