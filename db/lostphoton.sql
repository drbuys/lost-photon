DROP TABLE users;
DROP TABLE comments;
DROP TABLE photos;
DROP TABLE cameras;
DROP TABLE lenses;


CREATE TABLE users (
  id serial4 primary key,
  name VARCHAR(255)
);

CREATE TABLE comments (
  id serial4 primary key,
  name VARCHAR(255),
  artist_id int4 references artists(id) ON DELETE CASCADE
);

CREATE TABLE photos (
  id serial4 primary key,
  name VARCHAR(255),
  artist_id int4 references artists(id) ON DELETE CASCADE
);

CREATE TABLE cameras (
  id serial4 primary key,
  name VARCHAR(255),
  artist_id int4 references artists(id) ON DELETE CASCADE
);

CREATE TABLE lenses (
  id serial4 primary key,
  name VARCHAR(255),
  artist_id int4 references artists(id) ON DELETE CASCADE
);
