
with cte1 as (select city_id,trip_count,sum(repeat_passenger_count) as passenger_per_city_trip,(select sum(repeat_passenger_count)from dim_repeat_trip_distribution) as total_passenger_count 
from dim_repeat_trip_distribution group by trip_count,city_id)
select city_name,trip_count,ROUND((cte1.passenger_per_city_trip / cte1.total_passenger_count) * 100, 2) AS passenger_percentage
FROM cte1
join
dim_city on cte1.city_id=dim_city.city_id
WHERE cte1.trip_count IN ('2-Trips', '3-Trips', '4-Trips', '5-Trips', '6-Trips', '7-Trips', '8-Trips', '9-Trips', '10-Trips');





















WITH Passenger_Count AS (
SELECT city_id, trip_count, SUM(repeat_passenger_count) AS 'passenger_count_city' , 
(SELECT SUM(repeat_passenger_count) FROM dim_repeat_trip_distribution) as 'Passenger_count'
FROM dim_repeat_trip_distribution
GROUP BY trip_count,city_id )
SELECT 
	c.city_name, 
    ROUND((SUM(CASE WHEN pc.trip_count = 2 THEN pc.passenger_count_city ELSE 0 END) / MAX(pc.Passenger_count))*100, 2)  AS '2_trips_%',
    ROUND((SUM(CASE WHEN pc.trip_count = 3 THEN pc.passenger_count_city ELSE 0 END) / MAX(pc.Passenger_count))*100, 2)  AS '3_trips_%',
    ROUND((SUM(CASE WHEN pc.trip_count = 4 THEN pc.passenger_count_city ELSE 0 END) / MAX(pc.Passenger_count))*100, 2)  AS '4_trips_%',
    ROUND((SUM(CASE WHEN pc.trip_count = 5 THEN pc.passenger_count_city ELSE 0 END) / MAX(pc.Passenger_count))*100, 2)  AS '5_trips_%',
    ROUND((SUM(CASE WHEN pc.trip_count = 6 THEN pc.passenger_count_city ELSE 0 END) / MAX(pc.Passenger_count))*100, 2)  AS '6_trips_%',
    ROUND((SUM(CASE WHEN pc.trip_count = 7 THEN pc.passenger_count_city ELSE 0 END) / MAX(pc.Passenger_count))*100, 2)  AS '7_trips_%',
    ROUND((SUM(CASE WHEN pc.trip_count = 8 THEN pc.passenger_count_city ELSE 0 END) / MAX(pc.Passenger_count))*100, 2)  AS '8_trips_%',
    ROUND((SUM(CASE WHEN pc.trip_count = 9 THEN pc.passenger_count_city ELSE 0 END) / MAX(pc.Passenger_count))*100, 2)  AS '9_trips_%',
    ROUND((SUM(CASE WHEN pc.trip_count = 10 THEN pc.passenger_count_city ELSE 0 END) / MAX(pc.Passenger_count))*100, 2) AS '10_trips_%'
FROM 
    Passenger_Count pc 
INNER JOIN dim_city c ON c.city_id = pc.city_id
    
GROUP BY 
    pc.city_id,c.city_name;