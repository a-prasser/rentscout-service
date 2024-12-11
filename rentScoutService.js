
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
router.get('/properties', readProperties);
router.get('/properties/:id', readProperty);
router.get('/landlords', readLandlords);
router.get('/landlords/:id', readLandlord);
router.get('/students', readStudents);
router.get('/students/:id', readStudent);
router.get('/reviews', readReviews);
router.get('/reviews/:id', readReview);

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

// Student CRUD operations

function readStudents(req, res, next) {
  db.many('SELECT * FROM Student')
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

// Landlord CRUD operations

function readLandlords(req, res, next) {
  db.many('SELECT * FROM Landlord')
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

// Property CRUD operations

function readProperties(req, res, next) {
  db.many('SELECT * FROM Property')
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

// Review CRUD operations

function readReviews(req, res, next) {
  db.many('SELECT * FROM Review')
    .then((data) => {
      res.send(data);
    })
    .catch((err) => {
      next(err);
    });
}

function readReview(req, res, next) {
  db.oneOrNone('SELECT * FROM Review WHERE id=${id}', req.params)
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