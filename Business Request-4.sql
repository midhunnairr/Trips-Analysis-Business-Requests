
with top as (select city_id,sum(new_passengers) as total,rank() over(order by sum(new_passengers) desc) as ranking
 from fact_passenger_summary group by city_id)
 select city_name,top.total,
case when top.ranking in (1,2,3) then "Top 3"
when top.ranking in (8,9,10) then "Bottom 3"
else "middle"
end as category
from top join dim_city
on top.city_id=dim_city.city_id order by total desc;