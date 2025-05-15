# 🛠️ RentScout Service

This repository contains the backend service component for the [**RentScout**](https://github.com/a-prasser/rentscout-project?tab=readme-ov-file) project — a mobile-first rental platform designed for Calvin University students to explore and evaluate off-campus housing options.

---

## 📌 About the Service

This RESTful API powers the RentScout mobile application by exposing data endpoints for students, landlords, properties, and reviews. It is implemented as a standalone service to simplify deployment and maintenance using **Azure Web Apps** and **PostgreSQL**.

The service was originally based on the [**Monopoly Webservice Project**](https://github.com/calvin-cs262-organization/monopoly-service) by *kvlinden* and has since been extended to support RentScout’s data model and application logic.

---

## 📚 Available API Routes

The following endpoints return JSON-formatted data:

| Endpoint            | Description                                 |
|---------------------|---------------------------------------------|
| `/`                 | Returns a welcome message                   |
| `/students`         | Returns a list of all students              |
| `/students/:id`     | Returns data for a specific student         |
| `/landlords`        | Returns a list of all landlords             |
| `/landlords/:id`    | Returns data for a specific landlord        |
| `/properties`       | Returns a list of all properties            |
| `/properties/:id`   | Returns data for a specific property        |
| `/reviews`          | Returns a list of all reviews               |
| `/reviews/:id`      | Returns reviews for a specific property ID  |

---

## 🗃️ Database Design

The backend service uses a **relational PostgreSQL** database hosted on **Azure**. The schema includes tables for:

- Students  
- Landlords  
- Properties  
- Reviews  

> 📁 SQL schema definitions are included in the [`sql/`](./sql/) directory.

All sensitive database connection credentials (e.g., server address, username, password) are stored securely in Azure App Settings and are not exposed in this public repository.

---

## ☁️ Deployment Notes

This service is deployed independently from the mobile client for streamlined CI/CD integration with Azure. This separation simplifies testing, updating, and scaling the backend infrastructure without affecting the user-facing frontend.

> No local run instructions are included, as this service is not meant to be executed independently during normal use.

---

## 🧑‍💻 Project Context

This API is one part of the full **RentScout** system, which also includes:
- 📱 [React Native Mobile Client](https://github.com/a-prasser/rentscout-client)  
- 📄 [Main Project Repo with Design Docs](https://github.com/a-prasser/rentscout-project?tab=readme-ov-file)

This backend was developed as part of the **CS 262 Software Engineering** course at **Calvin University**.

---

## 📎 License & Credits

This project was inspired by and adapted from the [Monopoly Webservice Project](https://github.com/kvlinden/monopoly-service).  
It is maintained and extended by student developers at Calvin University.

