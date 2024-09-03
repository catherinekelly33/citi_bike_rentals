--- Create a view of the number and type of rentals
CREATE VIEW daily_rentals AS
SELECT j.date,
    count(j.journey_id) AS total_rentals,
    count(r.user_type) FILTER (WHERE r.user_type = 'Subscriber'::text) AS subscriber_rentals,
    count(r.user_type) FILTER (WHERE r.user_type = 'Customer'::text) AS customer_rentals,
    count(r.user_type) FILTER (WHERE r.user_type = 'Unknown'::text) AS unknown_rentals
  FROM journey AS j
    JOIN rider AS r 
      ON j.user_id = r.user_id
GROUP BY j.date
ORDER BY j.date;


--- Create a view of daily_rentals in relation to the weather and weekday/weekend
CREATE VIEW daily_rentals_weather AS
SELECT dr.date,
    dr.total_rentals,
    dr.subscriber_rentals,
    dr.customer_rentals,
    dr.unknown_rentals,
    w.rain,
    w.snow,
    w.tavg,
    w.average_wind_speed,
    d.weekend
  FROM daily_rentals AS dr
    JOIN weather AS w 
      ON dr.date = w.date
    JOON date AS d 
      ON dr.date = d.date
ORDER BY dr.date;


--- Create a view of the monthly rental data
CREATE VIEW monthly_rentals AS
SELECT d.month,
    d.month_id,
    sum(drw.total_rentals) AS total_rentals,
    round(avg(drw.total_rentals)) AS average_rentals,
    sum(drw.subscriber_rentals) AS total_subscriber_rentals,
    round(avg(drw.subscriber_rentals)) AS average_subscriber_rentals,
    sum(drw.customer_rentals) AS total_customer_rentals,
    round(avg(drw.customer_rentals)) AS average_customer_rentals,
    sum(drw.unknown_rentals) AS total_unknown_rentals,
    round(avg(drw.unknown_rentals)) AS average_unknown_rentals,
    count(drw.rain) FILTER (WHERE drw.rain) AS days_with_rain,
    count(drw.snow) FILTER (WHERE drw.snow) AS days_with_snow,
    round(avg(drw.tavg)) AS average_temperature,
    round(avg(drw.average_wind_speed)) AS average_wind_speed
   FROM daily_rentals_weather AS drw
     JOIN date AS d 
       ON drw.date = d.date
GROUP BY d.month, d.month_id
ORDER BY d.month_id;


--- Create a view of those rentals which exceeded the duration limit
CREATE VIEW exceeded_duration AS
SELECT j.date,
   j.bike_id,
   ( SELECT s.station_name
        FROM station AS s
        WHERE j.start_station_id = s.station_id) AS start_station,
   ( SELECT s.station_name
        FROM station AS s
        WHERE j.end_station_id = s.station_id) AS end_station,
   r.user_type
  FROM journey AS j
    JOIN rider AS r 
      ON j.user_id = r.user_id
WHERE j.duration_exceeded = true
ORDER BY j.date;


--- Create a view of the user demographics
CREATE VIEW users AS
SELECT count(j.journey_id) AS total_trips,
    r.user_type,
    r.gender,
    round(avg(r.age)) AS average_age
  FROM journey AS j
    JOIN rider AS r 
      ON j.user_id = r.user_id
GROUP BY r.gender, r.user_type
ORDER BY r.gender, r.user_type;