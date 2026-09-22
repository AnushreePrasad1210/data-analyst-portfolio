select count(*) as total_orders from orders ;

-- Late Delivery Rate

select  count(*) as total_orders,
sum(Late_delivery_risk) as late_orders,
round(sum(late_delivery_risk)*100.0/count(*),2) as late_delivery_pct
from orders;

-- Late Delivery Rate by Shipping Mode

select 
Shipping_Mode,
count(*) as total_orders,
sum(Late_delivery_risk) as late_orders,
round(sum(late_delivery_risk)*100.0/count(*),2) as late_delivery_pct
from orders
group by Shipping_Mode
order by late_delivery_pct desc;

-- Comparing Actual vs. Scheduled Days by Mode

select 
    Shipping_Mode,
    round(avg(Days_for_shipping_real), 2) as avg_actual_days,
    round(avg(Days_for_shipment_scheduled), 2) as avg_scheduled_days,
    round(avg(Days_for_shipping_real) - avg(Days_for_shipment_scheduled), 2) as avg_days_over_promise
from orders
Group by Shipping_Mode
order by avg_days_over_promise DESC;

-- verifying 

select
    Shipping_Mode,
    case 
        when (Days_for_shipping_real - Days_for_shipment_scheduled) <= 0 then 'On Time or Early'
        when (Days_for_shipping_real - Days_for_shipment_scheduled) = 1 then '1 Day Late'
        when (Days_for_shipping_real - Days_for_shipment_scheduled) = 2 then'2 Days Late'
        else '3+ Days Late'
    end as  lateness_bucket,
    count(*) as order_count
from orders
group by Shipping_Mode, lateness_bucket
order by Shipping_Mode, lateness_bucket;

-- Comparing Our Calculation Against the Dataset's Own Labels

select
Delivery_Status,
Late_delivery_risk,
count(*) as order_count
from orders
group by  Delivery_Status, Late_delivery_risk
order by Delivery_Status;

-- Late Delivery Rate by Market and Region

-- First, the broader Market-level view
select 
Market,
count(*) as total_orders,
sum(Late_delivery_risk) as late_orders,
round(sum(Late_delivery_risk) * 100.0 / count(*), 2) as late_delivery_pct
from orders
group by Market
order by late_delivery_pct desc;

--  finer Region-level view
select
Order_Region,
count(*) as total_orders,
sum(Late_delivery_risk) as late_orders,
round(sum(Late_delivery_risk) * 100.0 / count(*), 2) AS late_delivery_pct
from orders
group by  Order_Region
order by late_delivery_pct desc;

with region_lateness as (
-- late delivery % for each region, along with its market
select
Market,
Order_Region,
count(*) as total_orders,
sum(Late_delivery_risk) as late_orders,
round(sum(Late_delivery_risk) * 100.0 / count(*), 2) as late_delivery_pct
from orders
group by Market, Order_Region
)
-- rank each region within its own market
select 
Market,
Order_Region,
total_orders,
late_delivery_pct,
rank()over(
partition by Market 
order by  late_delivery_pct desc
) as rank_within_market
from region_lateness
order by Market, rank_within_market;

-- Time Trend Analysis — Problem Getting Better or Worse?

select
date_format(order_date, '%Y-%m') as order_month,
count(*) as total_orders,
sum(Late_delivery_risk) as late_orders,
round(sum(Late_delivery_risk) * 100.0 / count(*), 2) as late_delivery_pct
from orders
group by order_month
order by order_month;

-- Which Product Categories Suffer Most From the First Class Problem

WITH first_class_by_category AS (
-- filter to ONLY First Class orders, then group by product category
select
Category_Name,
count(*) as total_orders,
sum(Late_delivery_risk) as late_orders,
round(sum(Late_delivery_risk) * 100.0 / count(*), 2) as late_delivery_pct,
round(sum(Order_Item_Total), 2) as total_revenue_at_risk
from orders
where Shipping_Mode = 'First Class'
group by Category_Name
)

-- rank categories by how much revenue is tied up in this problem
select
Category_Name,
total_orders,
late_delivery_pct,
total_revenue_at_risk,
rank() over (order by total_revenue_at_risk desc) as revenue_risk_rank
from first_class_by_category
order by revenue_risk_rank
limit 10;



