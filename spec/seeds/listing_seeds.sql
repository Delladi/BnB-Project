DROP TABLE IF EXISTS listings CASCADE;

-- Table Definition
CREATE TABLE listings (
  id SERIAL PRIMARY KEY,
  listing_name text,
  available_from Date,
  available_from_to Date,
  price_per_night Decimal,
  location text,
  user_id int
);

TRUNCATE TABLE listings RESTART IDENTITY;

INSERT INTO listings ("listing_name", "available_from", "available_to", "price_per_night", "location", "user_id" ) VALUES
  ("Stylish Gettaway Cottage" 2023-01-01, 2023-01-05, '300.00', "Hampshire", 1),
  ("Whispering Pines Retreat" 2023-06-17, 2023-07-27, '400.00', "Surrey", 2),
  ("Scottish Castle" 2023-05-28, 2023-09-30, '500.00', "Scottland", 2),
  ("Cozy Bliss Cabin" 2023-08-20, 2023-08-25, '600.00', "Wiltshire" 3);