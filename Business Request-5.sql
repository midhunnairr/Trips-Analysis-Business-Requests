
with 
cte as (select city_id,sum(fare_amount) as revenue ,monthname(date) as month,
rank() over(partition by city_id order by sum(fare_amount) desc) as rankings
from fact_trips group by city_id,monthname(date)),
cte1 as(select city_id,sum(fare_amount) as total from fact_trips group by city_id)
select cte1.city_id,revenue,month,(revenue/total)*100 as percentage_contribution,(revenue/(select sum(fare_amount) from fact_trips))*100 as contribution_to_whole
from cte1 join cte on cte1.city_id=cte.city_id join dim_city on cte.city_id=dim_city.city_id where rankings=1;



