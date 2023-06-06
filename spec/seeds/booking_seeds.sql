DROP TABLE IF EXISTS bookings CASCADE;

-- Table Definition
CREATE TABLE bookings (
  id SERIAL PRIMARY KEY,
  date_from Date,
  date_to Date,
  price_total Decimal,
  user_id int
);

TRUNCATE TABLE bookings RESTART IDENTITY;

INSERT INTO bookings ("date_from", "date_to", "price_total", "user_id" ) VALUES
  ('2023-05-27', '2023-06-17', '6300.00', 1),
  ('2023-03-10', '2023-03-15', '2000.00', 2),
  ('2023-10-11', '2023-10-21', '5000.00', 2),
  ('2023-12-16', '2023-12-24', '4800.00', 3);