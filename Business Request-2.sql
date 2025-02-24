

with sup as(select (count(trip_id)-sum(distinct total_target_trips)) as difference,count(trip_id) as actual,monthname(month) as month,city_name,monthly_target_trips.city_id,sum(distinct total_target_trips) as target from monthly_target_trips 
join trips_db.dim_city on
monthly_target_trips.city_id=trips_db.dim_city.city_id 
join trips_db.fact_trips on
monthname(date) = monthname(month) and monthly_target_trips.city_id=trips_db.fact_trips.city_id
group by monthly_target_trips.city_id,month)
select city_name,actual,target,month,if(difference>0,"Above Target","Below Target") as differential_status,(difference/target)*100 as status  from sup;



