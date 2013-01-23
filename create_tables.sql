

CREATE TABLE chefs (
  id INTEGER PRIMARY KEY,
  first_name VARCHAR(255),
  last_name VARCHAR(255),
  mentor_id INTEGER REFERENCES chefs(id)
);

CREATE TABLE restaurants (
  id INTEGER PRIMARY KEY,
  name VARCHAR(255),
  neighborhood VARCHAR(255),
  cuisine VARCHAR(255)
);

CREATE TABLE tenures (
  id INTEGER PRIMARY KEY,
  chef_id INTEGER,
  restaurant_id INTEGER,
  start_date DATE,
  end_date DATE,
  FOREIGN KEY(chef_id) REFERENCES chefs(id),
  FOREIGN KEY(restaurant_id) REFERENCES restaurants(id)
);

CREATE TABLE critics (
  id INTEGER PRIMARY KEY,
  screen_name VARCHAR(255)
);

CREATE TABLE reviews (
  id INTEGER PRIMARY KEY,
  critic_id INTEGER,
  restaurant_id INTEGER,
  review TEXT,
  score INTEGER,
  date_of_review DATE,
  FOREIGN KEY(critic_id) REFERENCES critics(id),
  FOREIGN KEY(restaurant_id) REFERENCES restaurants(id)
);