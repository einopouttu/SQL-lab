select utm_content, count(ws.website_session_id) sessions from website_sessions ws left join orders o
on o.website_session_id=ws.website_session_id where ws.website_session_id between 1000 and 2000
group by 1
order by 2 desc

select utm

select utm_source, utm_campaign, http_referer, count(website_session_id) sessions
from website_sessions
where created_at < '2012-04-12'
group by utm_source, utm_campaign, http_referer


select count(ws.website_session_id) sessions, count(order_id) orders,
count(order_id)/count(ws.website_session_id) CVR
from website_sessions ws
left join orders o on o.website_session_id = ws.website_session_id
where ws.created_at < '2012-04-14'
and utm_source='gsearch'
and utm_campaign='nonbrand'

select * from orders
select * from website_sessions

select
week(created_at),
year(created_at),
min(date(created_at)) week_start,
count(website_session_id) sessions
from website_sessions
where website_session_id between 10000 and 115000
group by 1,2

select
primary_product_id,
count(case when items_purchased=1 then order_id else null end) orderswith1item,
count(case when items_purchased=2 then order_id else null end) orderswith2items,
count(order_id) total
from orders
where order_id between 31000 and 32000
group by 1
order by 1

select
min(date(created_at)) week_start_date,
count(website_session_id)
from website_sessions
where created_at < '2012-05-10'
and utm_source='gsearch'
and utm_campaign='nonbrand'
group by week(created_at)

select
ws.device_type,
count(ws.website_session_id) sessions,
count(o.website_session_id) orders,
count(o.website_session_id)/count(ws.website_session_id) CVR_by_device
from website_sessions ws
left join orders o on o.website_session_id=ws.website_session_id
where ws.created_at<'2012-05-11'
group by 1
order by 1

select
min(date(created_at)) week_start_date,
count(case when device_type='desktop' then website_session_id else null end) dtop,
count(case when device_type='mobile' then website_session_id else null end) mob
from website_sessions
where created_at < '2012-06-09'
and utm_source='gsearch'
and utm_campaign='nonbrand'
group by week(created_at)







