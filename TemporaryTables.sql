use mavenfuzzyfactory_2
create temporary table first_pageview
select 
website_session_id,
min(website_pageview_id) as min_pv_id
from website_pageviews
where website_pageview_id<1000
group by 1

select
wp.pageview_url landing_page,
count(fp.website_session_id) sessions_hitting
from first_pageview fp
left join website_pageviews wp
on wp.website_pageview_id= fp.min_pv_id
group by 1

create temporary table pageviews

select
pageview_url,
count(website_pageview_id)
from website_pageviews
where created_at < '2012-06-09'
group by 1
order by 2 desc

create temporary table first_pageview_2
select 
website_session_id,
min(website_pageview_id) as min_pv_id
from website_pageviews
group by 1

select*from website_pageviews


select
ws.pageview_url landing_page,
count(fp.website_session_id) sessions_hitting
from first_pageview_2 fp
left join  website_pageviews ws  on fp.min_pv_id=ws.website_pageview_id
where created_at < '2012-06-12'
group by 1
order by 2 desc



