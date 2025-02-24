SELECT * FROM trips_db.fact_trips;


select city_name,count(trip_id) as total_trips,sum(fare_amount)/sum(distance_travelled_km) as avg_fare_per_km,
sum(fare_amount)/count(trip_id) as avg_fare_per_trip,
(count(fact_trips.city_id)/(select count(fact_trips.city_id) from fact_trips))*100 as contribution_percentage 
from fact_trips join dim_city on fact_trips.city_id=dim_city.city_id group by fact_trips.city_id;





