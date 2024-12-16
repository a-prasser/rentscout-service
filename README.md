# RentScout Service

This is the Service application for the [CS 262 RentScout Project](https://github.com/calvin-cs262-fall2024-teamG/Project), which is deployed here:

- <https://cs262-webapp.azurewebsites.net](https://cs262-webapp.azurewebsites.net>

It has the following read data route URLs:

- `/` a hello message
- `/students` a list of students
- `/students/:id` a single student with given ID
- `/landlords` a list of landlords
- `/landlords/:id` a single landlord with given ID
- `/properties` a list of properties
- `/properties/:id` a single property with given ID
- `/reviews` a list of reviews
- `/reviews/:id` a list of reviews with given propertyID

It Is built out of the [Monopoly Webservice Proejct](https://github.com/calvin-cs262-organization/monopoly-service) by kvlinden

The database is relational with the schema specified in the `sql/` sub-directory
and is hosted on [Azure PostgreSQL](https://azure.microsoft.com/en-us/products/postgresql/).
The database server, user and password are stored as Azure application settings so that they 
aren&apos;t exposed in this (public) repo.

We implement this sample service as a separate repo to simplify Azure integration;
it&apos;s easier to auto-deploy a separate repo to Azure.