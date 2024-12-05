--
-- This SQL script implements sample queries on the Rentscout database.
--
-- @author Theo Perumal
-- @version Fall, 2024
--


-- Get a list of landlords
SELECT *
  FROM landlords
  ;

-- Get a list of all properties owned by a landlord called Erik Kraayveld
SELECT properties.*
  FROM properties
       JOIN landlords ON properties.landlord_id = landlords.id
 WHERE landlords.name = 'Erik Kraayveld'
  ;

-- Get a list of all properties of price under 2100
SELECT *
  FROM properties
 WHERE price < 2100
  ;

-- Get the cheapest property listed
SELECT *
  FROM properties
ORDER BY price ASC
 LIMIT 1
  ;