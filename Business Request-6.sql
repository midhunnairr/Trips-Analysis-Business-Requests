

with cte as(select city_id,sum(total_passengers) as city_total,sum(repeat_passengers) as city_repeat,
(sum(repeat_passengers)/sum(total_passengers))*100 as city_rpr 
from fact_passenger_summary group by city_id),

cte1 as (select city_id,monthname(month) as month,sum(total_passengers) as monthly_total,sum(repeat_passengers) as monthly_repeat,
(sum(repeat_passengers)/sum(total_passengers))*100 as monthly_rpr 
from fact_passenger_summary group by monthname(month),city_id)

select city_name,month,cte.city_id,city_total,city_repeat,city_rpr,monthly_total,monthly_repeat,monthly_rpr 
from cte join cte1 on cte.city_id=cte1.city_id join dim_city on cte.city_id=dim_city.city_id;


