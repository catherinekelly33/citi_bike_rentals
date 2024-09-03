# Bike Rental Data Management Writeup

## Project Overview
The popularity of bike and e-bike rental schemes has increased rapidly throughout
major cities around the world. This project creates a relational database to store
bike rental data from Citi Bike and weather data from NOAA and analytics-ready views
to probe the data:

The project was achieved via:
* inspecting and cleaning the datasets from Citi Bike and NOAA using Python
* designing a relational database structure 
* creating a PostgreSQL database and importing the data from the Jupyter notebook
* using SQL to develop analytics-ready database views 

## Inspecting and cleaning the datasets
The datasets used in this project are Jersey City's monthly Citi Bike journey records
from 2016 and daily NOAA weather data from Newark Airport over the same period. The 
Citi Bike records were concatenated and then, along with the weather data, inspected
and cleaned.

Some data was missing from the user type and birth year columns of the Citi Bike
datasets. Although there was no missing data in the gender column, one entry was 0
which represented unknown and is therefore effectively missing data. The missing
user types still contained useful information and was therefore retained with the Nan
entries changed to unknown. The majority of the missing birth year and gender=0
data was from the customer user type. This could not be deleted as it makes up 99.7% 
of the customer data. 

The Citi Bike data also contained some outliers. The year of birth of one rider gave
an age of 116 years old and was therefore removed. An additional column was inserted 
that gave the age of the rider as this is easier to read than the birth year. There 
were also 93 journeys that exceeded the maximum 24 hours rental time. As this data 
may be caused by bad docking it was important that the results remained. A new column 
was added stating if the time limit was exceeded. In addition, a new column containing 
the duration in minutes was added as this is more meaningful than seconds. 

In addition, columns were added to give the day of the week, month, month number and
whether it is on a weekend. 

The weather dataset contained lots of irrelevant data to the project and these columns
were removed. Boolean rain and snow columns were also added.

## Designing a relational database structure 
The Citi Bike table was split into multiple tables for clarity. The rider demographics 
were extracted and connected to the journey table via user_id. The station data was 
also extracted into an individual table and connected to the journey table via the 
start_station_id and end_station_id. A date table was also produced containing the date, 
day of the week, month and if it is a weekend.

The weather table was connected to the journey table via the date.

## Creating a PostgreSQL database and importing the data 
A database schema specifying data types and primary/foreign key relationships was
created based on these tables. This was then used to create a PostgreSQL database
and SQLAlchemy and pandas used to insert the data into the database.

## Developing analytics-ready database views
The following views were developed:

### daily_rentals
This view contains the rental data broken down day by day. It contains:
* The total number of rentals per day
* Rental breakdowns by user type and day

### daily_rentals_weather
This view consists of the daily_rental data along with the weather each day. It contains:
* The total number of rentals per day
* Rental breakdowns by user type and day
* Rain, snow, tavg and average wind speed for each day
* If the date falls on a weekend

### monthly_rentals
This view contains a breakdown of rentals and the average weather per month. It contains:
* Total and average rentals per month
* Total and average rentals per month by user type
* The number of wet or snowy days per month
* The monthly average temperature
* The monthly average wind speed

### exceeded_duration
This view contains data from the rides exceeding the maximum duration. It contains:
* Date
* Bike id
* Start and end stations
* User type

### users
This view breaks down the journeys into user type and gender and gives the average
age for each group. It consists of:
* Total trips by user type and gender
* Average age of each user type / gender combination.



 