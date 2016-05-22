DROP VIEW photographers;
DROP TABLE comments;
DROP TABLE photos;
DROP TABLE cameras;
DROP TABLE lenses;
DROP TABLE users;

CREATE TABLE users (
  id SERIAL8 primary key,
  username VARCHAR(255),
  fullname VARCHAR(255),
  isphotographer BOOLEAN DEFAULT FALSE
);

CREATE VIEW photographers AS
SELECT id, username
FROM users
WHERE isphotographer = TRUE;

CREATE TABLE cameras (
  id serial8 primary key,
  make VARCHAR(255),
  model VARCHAR(255)
);

CREATE TABLE lenses (
  id serial4 primary key,
  make VARCHAR(255),
  model VARCHAR(255)
);

CREATE TABLE photos (
  id serial8 primary key,
  name VARCHAR(255),
  object VARCHAR(255),
  datetaken DATE,
  location VARCHAR(255),
  aperture NUMERIC,
  shutterspeed VARCHAR(255),
  photographer_id INT8 references users(id) ON DELETE CASCADE,
  camera_id INT8 references cameras(id) ON DELETE CASCADE,
  lens_id INT8 references lenses(id) ON DELETE CASCADE
);

CREATE TABLE comments (
  id SERIAL8 primary key,
  user_id INT8 references users(id) ON DELETE CASCADE,
  photo_id INT8 references photos(id) ON DELETE CASCADE,
  rating INT8,
  post VARCHAR(255)
);
