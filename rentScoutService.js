
/**
 * This module implements a REST-inspired webservice for the RentScout DB.
 * The database is hosted on Azure PostgreSQL.
 * *
 * To guard against SQL injection attacks, this code uses pg-promise's built-in
 * variable escaping.
 * We don't use JS template strings because it doesn't filter
 * client-supplied values properly.
 *
 * This service assumes that the database connection strings and the server mode are
 * set in environment variables. See the DB_* variables used by pg-promise.
 *
 * @author: jtlun
 * @date: Fall, 2024
 */

// Set up the database connection.

const pgp = require('pg-promise')();

const db = pgp({
  host: process.env.DB_SERVER,
  port: process.env.DB_PORT,
  database: process.env.DB_DATABASE,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
});

// Configure the server and its routes.

const express = require('express');
const cors = require('cors');

const app = express();
const port = process.env.PORT || 3000;
const router = express.Router();
router.use(express.json());
app.use(cors());

router.get('/', readHelloMessage);

router.get('/students', readStudents);

router.post('/students', createStudent);
router.get('/students/:id', readStudent);
router.put('/students/:id', updateStudent);
router.delete('/students/:id', deleteStudent);

router.get('/landlords', readLandlords);

router.post('/landlords', createLandlord);
router.get('/landlords/:id', readLandlord);
router.put('/landlords/:id', updateLandlord);
router.delete('/landlords/:id', deleteLandlord);

router.get('/properties', readProperties);

router.post('/properties', createProperty);
router.get('/properties/:id', readProperty);
router.put('/properties/:id', updateProperty);
router.delete('/properties/:id', deleteProperty);

router.get('/reviews', readReviews);

router.get('/reviews/:id', readReviewsProperty);

router.post('/reviews', createReview);
router.get('/reviews/:studentID/:propertyID', readReview);
router.put('/reviews/:studentID/:propertyID', updateReview);
router.delete('/reviews/:studentID/:propertyID', deleteReview);

app.use(router);
app.listen(port, () => console.log(`Listening on port ${port}`));

// Implement the CRUD operations.

// Currently only the Read operations are implemented.

function returnDataOr404(res, data) {
  if (data == null) {
    res.sendStatus(404);
  } else {
    res.send(data);
  }
}

function readHelloMessage(req, res) {
  res.send('RentScout Web Service is running\nFor more information, see https://github.com/calvin-cs262-fall2024-teamG/Service/blob/main/README.md');
}

// Read All students

function readStudents(req, res, next) {
  db.many('SELECT * FROM Student')
    .then((data) => {
      res.send(data);
    })
    .catch((err) => {
      next(err);
    });
}

// CRUD Single Student

function createStudent(req, res, next) {
  db.one('INSERT INTO Student(email) VALUES (${email}) RETURNING id', req.body)
    .then((data) => {
      res.send(data);
    })
    .catch((err) => {
      next(err);
    });
}

function readStudent(req, res, next) {
  db.oneOrNone('SELECT * FROM Student WHERE id=${id}', req.params)
    .then((data) => {
      returnDataOr404(res, data);
    })
    .catch((err) => {
      next(err);
    });
}

function updateStudent(req, res, next) {
  db.oneOrNone('UPDATE Student SET email=${body.email} WHERE id=${params.id} RETURNING id', req)
    .then((data) => {
      returnDataOr404(res, data);
    })
    .catch((err) => {
      next(err);
    });
}

function deleteStudent(req, res, next) {
  db.oneOrNone('DELETE FROM Student WHERE id=${id} RETURNING id', req.params)
    .then((data) => {
      returnDataOr404(res, data);
    })
    .catch((err) => {
      next(err);
    });
}

// Read all landlords

function readLandlords(req, res, next) {
  db.many('SELECT * FROM Landlord')
    .then((data) => {
      res.send(data);
    })
    .catch((err) => {
      next(err);
    });
}

// CRUD Single Landlord

function createLandlord(req, res, next) {
  db.one('INSERT INTO Landlord(name, website, phoneNumber, emailAddress) VALUES (${name}, ${website}, ${phoneNumber}, ${emailAddress}) RETURNING id', req.body)
    .then((data) => {
      res.send(data);
    })
    .catch((err) => {
      next(err);
    });
}

function readLandlord(req, res, next) {
  db.oneOrNone('SELECT * FROM Landlord WHERE id=${id}', req.params)
    .then((data) => {
      returnDataOr404(res, data);
    })
    .catch((err) => {
      next(err);
    });
}

function updateLandlord(req, res, next) {
  db.oneOrNone('UPDATE Landlord SET name=${body.name}, website=${body.website}, phoneNumber=${body.phoneNumber}, emailAddress=${body.emailAddress} WHERE id=${params.id} RETURNING id', req)
    .then((data) => {
      returnDataOr404(res, data);
    })
    .catch((err) => {
      next(err);
    });
}

function deleteLandlord(req, res, next) {
  db.oneOrNone('DELETE FROM Landlord WHERE id=${id} RETURNING id', req.params)
    .then((data) => {
      returnDataOr404(res, data);
    })
    .catch((err) => {
      next(err);
    });
}

// Read All Properties

function readProperties(req, res, next) {
  db.many('SELECT * FROM Property')
    .then((data) => {
      res.send(data);
    })
    .catch((err) => {
      next(err);
    });
}

// CRUD Single Property

function createProperty(req, res, next) {
  db.one('INSERT INTO Property(landlordID, bannerImage, streetAddress, bedroomNum, bathroomNum, price, distanceToCalvin, distanceToBusStop, petFriendly) VALUES (${landlordID, ${bannerImage}, ${streetAddress}, ${bedroomNum}, ${bathroomNum}, ${price}, ${distanceToCalvin}, ${distanceToBusStop}, ${petFriendly}) RETURNING id', req.body)
    .then((data) => {
      res.send(data);
    })
    .catch((err) => {
      next(err);
    });
}

function readProperty(req, res, next) {
  db.oneOrNone('SELECT * FROM Property WHERE id=${id}', req.params)
    .then((data) => {
      returnDataOr404(res, data);
    })
    .catch((err) => {
      next(err);
    });
}

function updateProperty(req, res, next) {
  db.oneOrNone('UPDATE property SET landlordID=${body.landlordID}, bannerImage=${body.bannerImage}, streetAddress=${body.streetAddress}, bedroomNum=${body.bedroomNum}, bathroomNum=${body.bathroomNum}, price=${price}, distanceToCalvin=${distanceToCalvin}, distanceToBusStop=${distanceToBusStop}, petFriendly=${petFriendly} WHERE id=${params.id} RETURNING id', req)
    .then((data) => {
      returnDataOr404(res, data);
    })
    .catch((err) => {
      next(err);
    });
}

function deleteProperty(req, res, next) {
  db.oneOrNone('DELETE FROM Property WHERE id=${id} RETURNING id', req.params)
    .then((data) => {
      returnDataOr404(res, data);
    })
    .catch((err) => {
      next(err);
    });
}

// Read All Reviews

function readReviews(req, res, next) {
  db.many('SELECT * FROM Review')
    .then((data) => {
      res.send(data);
    })
    .catch((err) => {
      next(err);
    });
}

// Read Reviews for a Property

function readReviewsProperty(req, res, next) {
  db.oneOrNone('SELECT * FROM Review WHERE propertyID=${id}', req.params)
    .then((data) => {
      returnDataOr404(res, data);
    })
    .catch((err) => {
      next(err);
    });
}

// CRUD Single Review

function createReview(req, res, next) {
  db.one('INSERT INTO Review(studentID, propertyID, rating, reviewText) VALUES (${studentID}, ${propertyID}, ${rating}, ${reviewText})', req.body)
    .then((data) => {
      res.send(data);
    })
    .catch((err) => {
      next(err);
    });
}

function readReview(req, res, next) {
  db.oneOrNone('SELECT * FROM Review WHERE studentID=${studentID} AND propertyID=${propertyID}', req.params)
    .then((data) => {
      returnDataOr404(res, data);
    })
    .catch((err) => {
      next(err);
    });
}

function updateReview(req, res, next) {
  db.oneOrNone('UPDATE Review SET studentID=${body.studentID}, propertyID=${body.propertyID}, rating=${body.rating}, reviewText=${body.reviewText} WHERE studentID=${params.studentID} AND propertyID=${params.propertyID}', req)
    .then((data) => {
      returnDataOr404(res, data);
    })
    .catch((err) => {
      next(err);
    });
}

function deleteReview(req, res, next) {
  db.oneOrNone('DELETE FROM Review WHERE studentID=${studentID} AND propertyID=${propertyID}', req.params)
    .then((data) => {
      returnDataOr404(res, data);
    })
    .catch((err) => {
      next(err);
    });
}

// Archived Functions

// function updatePlayer(req, res, next) {
//   db.oneOrNone('UPDATE Player SET email=${body.email}, name=${body.name} WHERE id=${params.id} RETURNING id', req)
//     .then((data) => {
//       returnDataOr404(res, data);
//     })
//     .catch((err) => {
//       next(err);
//     });
// }

// function createPlayer(req, res, next) {
//   db.one('INSERT INTO Player(email, name) VALUES (${email}, ${name}) RETURNING id', req.body)
//     .then((data) => {
//       res.send(data);
//     })
//     .catch((err) => {
//       next(err);
//     });
// }

// function deletePlayer(req, res, next) {
//   db.oneOrNone('DELETE FROM Player WHERE id=${id} RETURNING id', req.params)
//     .then((data) => {
//       returnDataOr404(res, data);
//     })
//     .catch((err) => {
//       next(err);
//     });
// }