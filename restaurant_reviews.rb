require 'singleton'
require 'sqlite3'

# Ruby provides a `Singleton` module that will only let one
# `SchoolDatabase` object get instantiated. This is useful, because
# there should only be a single connection to the database; there
# shouldn't be multiple simultaneous connections. A call to
# `SchoolDatabase::new` will result in an error. To get access to the
# *single* SchoolDatabase instance, we call `#instance`.
class RestaurantReviewsDB < SQLite3::Database
  include Singleton

  def initialize
    # tell the SQLite3::Database the db file to read/write
    super("restaurant_reviews.db")

    # otherwise we get an array of values
    self.results_as_hash = true
    # otherwise everything is returned as a string
    self.type_translation = true
  end
end

def get_departments
  # execute a SELECT; result in an `Array` of `Hash`es, each
  # represents a single row.
  SchoolDatabase.instance.execute("SELECT * FROM departments")
end


def add_chef(name, mentor_id)
  if name.nil?
    name = get_chef_name
    mentor_id = get_mentor_id
  end

  first_name, last_name = name.split

  RestaurantReviewsDB.instance.execute(
    "INSERT INTO chefs ('first_name', 'last_name', 'mentor_id')
    VALUES (?, ?, ?)", first_name, last_name, mentor_id)
end

def add_restaurant(name, neighborhood, cuisine)
  if name.nil?
  end

  RestaurantReviewsDB.instance.execute(
    "INSERT INTO restaurants ('name', 'neighborhood', 'cuisine')
    VALUES (?, ?, ?)", name, neighborhood, cuisine)
end

def add_tenure(chef_id, restaurant_id, start_date, end_date)
  RestaurantReviewsDB.instance.execute(
    "INSERT INTO head_chef_tenures ('chef_id', 'restaurant_id', 'start_date', 'end_date')
    VALUES (?, ?, ?, ?)", chef_id, restaurant_id, start_date, end_date)
end

def add_critic(screen_name)
  RestaurantReviewsDB.instance.execute(
    "INSERT INTO critics ('screen_name')
    VALUES (?)", screen_name)
end

def add_restaurant_review(critic_id, restaurant_id, review, score, date)
  RestaurantReviewsDB.instance.execute(
  "INSERT INTO reviews ('critic_id', 'restaurant_id', 'review', 'score', 'date_of_review')
  VALUES (?, ?, ?, ?, ?)", critic_id, restaurant_id, review, score, date)
end

def get_restaurants(neighborhood)
  RestaurantReviewsDB.instance.execute(
    "SELECT id, name, cuisine
    FROM restaurants
    WHERE neighborhood = (?)", neighborhood)
end

def get_critics_reviews(critic)
  avg = RestaurantReviewsDB.instance.execute(
    "SELECT AVG(score)
    FROM critics
    JOIN reviews
    ON critics.id = reviews.critic_id
    WHERE critics.screen_name = (?)", critic)

  p avg

  RestaurantReviewsDB.instance.execute(
    "SELECT screen_name, date_of_review, review
    FROM critics
    JOIN reviews
    ON critics.id = reviews.critic_id
    WHERE critics.screen_name = (?)", critic)
end

def get_restaurant_reviews(restaurant)
  avg = RestaurantReviewsDB.instance.execute(
    "SELECT AVG(score)
    FROM restaurants
    JOIN reviews
    ON restaurants.id = reviews.restaurant_id
    WHERE restaurants.name = (?)", restaurant)

  p avg

  RestaurantReviewsDB.instance.execute(
    "SELECT name, date_of_review, review
    FROM restaurants
    JOIN reviews
    ON restaurants.id = reviews.restaurant_id
    WHERE restaurants.name = (?)", restaurant)
end













