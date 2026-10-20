select * from customer limit 10;
select item_purchased,avg(review_rating) as "Averagerating" from customer group by item_purchased order by avg(review_rating) desc limit 5;
select shipping_type,avg(purchase_amount) from customer where shipping_type in ('Standard','Express') group by shipping_type;
select subscription_status,count(customer_id),avg(purchase_amount) from customer group by subscription_status;
select item_purchased,round(sum(case when discount_applied ='Yes' then 1 else 0 end) / count(*) * 100,2) as discount_rate from customer group by item_purchased order by discount_rate limit 5;
select item_purchased,sum(case when discount_applied = 'Yes' then 1 else 0 end) / count(*) * 100 as discount_rate from customer group by item_purchased order by discount_rate desc limit 5; 
with customer_type as (
select customer_id,previous_purchases,
case 
   When previous_purchases=1 then 'New'
   when previous_purchases between 2 and 10 then 'Returning'
   else 'Loyal'
   end as customer_segment
from customer
)
select customer_segment ,count(*) as "numberofcustomer" from customer_type group by customer_segment;

with item_counts as (
select category,item_purchased, count(customer_id) as total_order ,
row_number() over(partition by cateogroy order by count(customer_id) Desc) as item_rank
from customer group by category,item_purchased
)
select item_rank,category,item_purchased,total_orders from item_counts where item_rank<=3;