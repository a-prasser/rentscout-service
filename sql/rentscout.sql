-- 
-- This sql is for the rentscout app
-- @author Theo Perumal
-- edited and updated by Jonathan Lundberg
-- Fall 2024

-- several pieces of data in this database are incorrect and merely for demonstration purposes
-- this includes:
-- property: pet friendly status and rating
-- landlord: phones, emails, and websites
-- student: names and emails
-- review: all

-- Drop outdated RentScout tables if they exist

DROP TABLE IF EXISTS Rview;
DROP TABLE IF EXISTS Property;
DROP TABLE IF EXISTS Landlord;
DROP TABLE IF EXISTS Student;

CREATE TABLE Student (
    ID SERIAL PRIMARY KEY,
    email varchar(255)
);

CREATE TABLE Landlord ( 
    ID SERIAL PRIMARY KEY,
    name varchar(100),
    website varchar(100),
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
    petFriendly BOOLEAN
);

CREATE TABLE Review (
    studentID integer REFERENCES Student(ID),
    propertyID integer REFERENCES Property(ID),
    rating integer,
    reviewText varchar(2047)
);

GRANT SELECT ON Student TO PUBLIC;
GRANT SELECT ON Landlord TO PUBLIC;
GRANT SELECT ON Property TO PUBLIC;
GRANT SELECT ON Review TO PUBLIC;

INSERT INTO Student VALUES (1, 'jtl23@calvin.edu');
INSERT INTO Student VALUES (2, 'tkp89@calvin.edu');

INSERT INTO Landlord VALUES (1, 'Erik Kraayeveld', 'https://www.kraayeveldproperties.com/', '616-123-4567', 'contact@kraayeveldproperties.com');
INSERT INTO Landlord VALUES (2, 'Cathy Sevigny', null, null, null);
INSERT INTO Landlord VALUES (3, 'Continental Properties Co', 'continentalProperties.org', '616-123-4567', 'contact@contentialProperties.org');
INSERT INTO Landlord VALUES (4, 'Brian Tagg', null, '616-987-6543', 'btagg@yahoo.com');
INSERT INTO Landlord VALUES (5, 'Shift Management LLC', null, null, null);
INSERT INTO Landlord VALUES (6, 'Aiesha Reynolds', null, '616-555-5555', 'aieshareynolds@outlook.com');
INSERT INTO Landlord VALUES (7, 'HCW Realty', null, null, null);
INSERT INTO Landlord VALUES (8, 'Rental Properties Consultant LLC', null, null, null);

INSERT INTO Property VALUES (1, 1, 'https://github.com/calvin-cs262-fall2024-teamG/Project/blob/main/StreetView%20Pics/1610%20Rossman.png', '1610 Rossman Ave, Grand Rapids MI, 49507', 5, 2.5, 2200, 2.2, 0.6, true);
INSERT INTO Property VALUES (2, 1, 'https://github.com/calvin-cs262-fall2024-teamG/Project/blob/main/StreetView%20Pics/1024%20Burton.png', '1024 Burton St SE, Grand Rapids, MI 49507', 4, 2, 1750, 2.8, 0.3, false);
INSERT INTO Property VALUES (3, 1, 'https://github.com/calvin-cs262-fall2024-teamG/Project/blob/main/StreetView%20Pics/1421%20Sherman.png', '1421 Sherman St SE, Grand Rapids, MI 49506', 5, 2, 2000, 2.8, 0.4, false);
INSERT INTO Property VALUES (4, 1, 'https://github.com/calvin-cs262-fall2024-teamG/Project/blob/main/StreetView%20Pics/249%20Alger.png', '249 Alger St SE, Grand Rapids, MI 49507', 5, 2, 1950, 3.8, 0.3, false);
INSERT INTO Property VALUES (5, 1, 'https://github.com/calvin-cs262-fall2024-teamG/Project/blob/main/StreetView%20Pics/1314%20Boston.png', '1314 Boston St SE, Grand Rapids, MI 40507', 4, 2, 1700, 2.5, 0.2, true);
INSERT INTO Property VALUES (6, 2, 'https://github.com/calvin-cs262-fall2024-teamG/Project/blob/main/StreetView%20Pics/118%20National.png', '118 National Ave SW, Grand Rapids, MI 49504', 2, 1, 1475, 5.4, 0.2, true);
INSERT INTO Property VALUES (7, 3, 'https://github.com/calvin-cs262-fall2024-teamG/Project/blob/main/StreetView%20Pics/2010%20Deciduous.png', '2010 Deciduous Dr, Grand Rapids MI 49505', 2, 3, 2280, 4.8, 0.7, false);
INSERT INTO Property VALUES (8, 4, 'https://github.com/calvin-cs262-fall2024-teamG/Project/blob/main/StreetView%20Pics/2142%20Stafford.png', '2142 Stafford Ave SW, Grand Rapids, MI 49507', 3, 1, 2000, 4.5, 0.3, true);
INSERT INTO Property VALUES (9, 4, 'https://github.com/calvin-cs262-fall2024-teamG/Project/blob/main/StreetView%20Pics/3476%20Bluebird.png', '3476 Bluebird Ave SW, Wyoming MI, 49519', 3, 1, 2100, 7.4, 0.3, false);
INSERT INTO Property VALUES (10, 5, 'https://github.com/calvin-cs262-fall2024-teamG/Project/blob/main/StreetView%20Pics/1126%20Merrifield.png', '1126 Merrifield St SE, Grand Rapids, MI 49507', 4, 1, 1895, 2.7, 0.2, false);
INSERT INTO Property VALUES (11, 6, 'https://github.com/calvin-cs262-fall2024-teamG/Project/blob/main/StreetView%20Pics/636%20Innes.png', '636 Innes St NE, Grand Rapids, MI 49503', 2, 1, 1000, 4.2, 0.4, true);
INSERT INTO Property VALUES (12, 7, 'https://github.com/calvin-cs262-fall2024-teamG/Project/blob/main/StreetView%20Pics/471%20Emerald.png', '471 Emerald Ave NE, Grand Rapids, MI 49503', 4, 1, 1900, 4.2, 0.2, false);
INSERT INTO Property VALUES (13, 8, 'https://github.com/calvin-cs262-fall2024-teamG/Project/blob/main/StreetView%20Pics/1020%20Sigsbee.png', '1020 Sigsbee St SE, Grand Rapids, MI 49506', 5, 2, 3200, 3.3, 0.1, true);

-- To generate demo reviews to show the system working, we will generate
-- 11 reviews for property 1, 10 for property 2, 9 for property 3, and so on

INSERT INTO Review VALUES (1, 1, 5, 'Great place to live! The landlord is very responsive and the property is well maintained.');
INSERT INTO Review VALUES (1, 2, 4, 'The property is nice, but the landlord is not very responsive.');
INSERT INTO Review VALUES (2, 3, 2, 'the property is not well maintained and the landlord is not responsive.');
INSERT INTO Review VALUES (2, 4, 3, 'The property is nice, but the landlord is not very responsive.');
INSERT INTO Review VALUES (1, 5, 5, 'Great place to live! The landlord is very responsive and the property is well maintained.');
INSERT INTO Review VALUES (2, 6, 1, 'I hate this place!!!');
INSERT INTO Review VALUES (1, 7, 4, 'The property is nice, but the landlord is not very responsive.');
INSERT INTO Review VALUES (2, 8, 3, 'The property is nice, but the landlord is not very responsive.');
INSERT INTO Review VALUES (1, 9, 5, 'Great place to live! The landlord is very responsive and the property is well maintained.');
INSERT INTO Review VALUES (2, 10, 2, 'the property is not well maintained and the landlord is not responsive.');
INSERT INTO Review VALUES (1, 11, 5, 'Great place to live! The landlord is very responsive and the property is well maintained.');

INSERT INTO Review VALUES (1, 1, 4, 'Excellent product, will buy again!');
INSERT INTO Review VALUES (2, 2, 3, 'Not bad, but could be improved.');
INSERT INTO Review VALUES (1, 3, 5, 'Would recommend to others.');
INSERT INTO Review VALUES (2, 4, 2, 'Pretty decent, but the quality isn’t top-notch.');
INSERT INTO Review VALUES (1, 5, 5, 'Five stars! Very satisfied with this purchase.');
INSERT INTO Review VALUES (2, 6, 2, 'Not great, had a few issues with it.');
INSERT INTO Review VALUES (1, 7, 4, 'It’s okay, but the price is a bit high.');
INSERT INTO Review VALUES (2, 8, 3, 'Good value for the money.');
INSERT INTO Review VALUES (1, 9, 1, 'The product arrived damaged, not happy with it.');
INSERT INTO Review VALUES (2, 10, 5, 'Amazing! Exceeded my expectations, highly recommend.');

INSERT INTO Review VALUES (1, 1, 4, 'Excellent product, will buy again!');
INSERT INTO Review VALUES (2, 2, 3, 'Not bad, but could be improved.');
INSERT INTO Review VALUES (1, 3, 5, 'Would recommend to others.');
INSERT INTO Review VALUES (2, 4, 2, 'Pretty decent, but the quality isn’t top-notch.');
INSERT INTO Review VALUES (1, 5, 5, 'Five stars! Very satisfied with this purchase.');
INSERT INTO Review VALUES (2, 6, 2, 'Not great, had a few issues with it.');
INSERT INTO Review VALUES (1, 7, 4, 'It’s okay, but the price is a bit high.');
INSERT INTO Review VALUES (2, 8, 3, 'Good value for the money.');
INSERT INTO Review VALUES (1, 9, 1, 'The product arrived damaged, not happy with it.');

INSERT INTO Review VALUES (1, 1, 4, 'Excellent product, will buy again!');
INSERT INTO Review VALUES (2, 2, 3, 'Not bad, but could be improved.');
INSERT INTO Review VALUES (1, 3, 5, 'Would recommend to others.');
INSERT INTO Review VALUES (2, 4, 2, 'Pretty decent, but the quality isn’t top-notch.');
INSERT INTO Review VALUES (1, 5, 5, 'Five stars! Very satisfied with this purchase.');
INSERT INTO Review VALUES (2, 6, 2, 'Not great, had a few issues with it.');
INSERT INTO Review VALUES (1, 7, 4, 'It’s okay, but the price is a bit high.');
INSERT INTO Review VALUES (2, 8, 3, 'Good value for the money.');

INSERT INTO Review VALUES (1, 1, 4, 'Excellent product, will buy again!');
INSERT INTO Review VALUES (2, 2, 3, 'Not bad, but could be improved.');
INSERT INTO Review VALUES (1, 3, 5, 'Would recommend to others.');
INSERT INTO Review VALUES (2, 4, 2, 'Pretty decent, but the quality isn’t top-notch.');
INSERT INTO Review VALUES (1, 5, 5, 'Five stars! Very satisfied with this purchase.');
INSERT INTO Review VALUES (2, 6, 2, 'Not great, had a few issues with it.');
INSERT INTO Review VALUES (1, 7, 4, 'It’s okay, but the price is a bit high.');

INSERT INTO Review VALUES (1, 1, 4, 'Excellent product, will buy again!');
INSERT INTO Review VALUES (2, 2, 3, 'Not bad, but could be improved.');
INSERT INTO Review VALUES (1, 3, 5, 'Would recommend to others.');
INSERT INTO Review VALUES (2, 4, 2, 'Pretty decent, but the quality isn’t top-notch.');
INSERT INTO Review VALUES (1, 5, 5, 'Five stars! Very satisfied with this purchase.');
INSERT INTO Review VALUES (2, 6, 2, 'Not great, had a few issues with it.');

INSERT INTO Review VALUES (1, 1, 4, 'Excellent product, will buy again!');
INSERT INTO Review VALUES (2, 2, 3, 'Not bad, but could be improved.');
INSERT INTO Review VALUES (1, 3, 5, 'Would recommend to others.');
INSERT INTO Review VALUES (2, 4, 2, 'Pretty decent, but the quality isn’t top-notch.');
INSERT INTO Review VALUES (1, 5, 5, 'Five stars! Very satisfied with this purchase.');

INSERT INTO Review VALUES (1, 1, 4, 'Excellent product, will buy again!');
INSERT INTO Review VALUES (0, 2, 3, 'Not bad, but could be improved.');
INSERT INTO Review VALUES (1, 3, 5, 'Would recommend to others.');
INSERT INTO Review VALUES (0, 4, 2, 'Pretty decent, but the quality isn’t top-notch.');

INSERT INTO Review VALUES (1, 1, 4, 'Excellent product, will buy again!');
INSERT INTO Review VALUES (2, 2, 3, 'Not bad, but could be improved.');
INSERT INTO Review VALUES (1, 3, 5, 'Would recommend to others.');

INSERT INTO Review VALUES (2, 1, 2, 'Pretty decent, but the quality isn’t top-notch.');
INSERT INTO Review VALUES (1, 2, 4, 'Good value for the money!');

INSERT INTO Review VALUES (2, 1, 5, 'Five stars! Very satisfied with this purchase.');