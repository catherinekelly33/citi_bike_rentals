--- journey table
CREATE TABLE journey (
  trip_duration INTEGER,
  start_time TIMESTAMP,
  stop_time TIMESTAMP,
  start_station_id INTEGER REFERENCES station(station_id),
  end_station_id INTEGER REFERENCES station(station_id),
  bike_id INTEGER,
  duration_exceeded BOOLEAN,
  duration_minutes FLOAT,
  date DATE REFERENCES weather(date),
  month_id INTEGER,
  user_id INTEGER REFERENCES user(user_id),
  date_id DATE REFERENCES date(date),
  journey_id INTEGER PRIMARY KEY);


--- rider table
CREATE TABLE rider (
  user_id INTEGER PRIMARY KEY,
  user_type VARCHAR(50),
  birth_year INTEGER,
  gender INTEGER, 
  age INTEGER);


--- weather table
CREATE TABLE weather (
  date TIMESTAMP PRIMARY KEY,
  rain BOOLEAN,
  snow BOOLEAN,
  tavg INTEGER,
  average_wind_speed FLOAT);


--- date table
CREATE TABLE date (
  date DATE PRIMARY KEY,
  day VARCHAR(10),
  month VARCHAR(10),
  month_id INTEGER,
  weekend BOOLEAN);
  

--- station table
CREATE TABLE station (
  station_id INTEGER PRIMARY KEY,
  station_name VARCHAR(100),
  station_latitude FLOAT,
  station_longitude FLOAT);


