#step1 find the first website_pageview_id for relevant sessions
#step2 identify the landing page of each session
#step3 counting pageviews for each session, to identify "bounces"
#step4 summarizing total sessions and bounced sessions, by LP

#finding minimum website pageview id associated with each session we care about

create temporary table first_pageview_demo
select
wp.website_session_id,
min(wp.website_session_id) minimum
from website_pageviews wp
inner join website_sessions ws
on ws.website_session_id=wp.website_session_id
group by 1

drop table first_pageview_demo
drop table session_landing_demo
drop table bounced_sessions
drop table bounced_sessions

create temporary table first_pageview_demo
select
wp.website_session_id,
min(wp.website_session_id) minimum
from website_pageviews wp
inner join website_sessions ws on wp.website_session_id=ws.website_session_id
where wp.pageview_url = '/home'
and wp.created_at < '2012-06-14'
group by 1

create temporary table session_landing_demo
select
fp.website_session_id,
wp.pageview_url landing_page
from first_pageview_demo fp
inner join website_pageviews wp on wp.website_pageview_id=fp.minimum

select* from session_landing_demo

create temporary table bounced_sessions
select
sld.website_session_id,
sld.landing_page,
count(wp.website_pageview_id) pages_viewed
from session_landing_demo sld
left join website_pageviews wp on wp.website_session_id=sld.website_session_id
group by 1,2
having count(wp.website_pageview_id) = 1

select*from website_pageviews

select*from bounced_sessions

select
count(sld.website_session_id) sessions,
count(bs.website_session_id) bounced_sessions,
count(bs.website_session_id)/count(sld.website_session_id) bounced_rate
from session_landing_demo sld
left join bounced_sessions bs on bs.website_session_id=sld.website_session_id
#group by 1
order by 1


#step1 find the first website_pageview_id for landingpage home
#step2 counting pageviews for each session, to identify "bounces"
#step3 summarizing total sessions and bounced sessions, by LP

create temporary table landing_page_1
select
wp.website_session_id,
min(wp.website_session_id) minimum
from website_pageviews wp
inner join website_sessions ws on wp.website_session_id=ws.website_session_id
where wp.pageview_url = '/home'
and wp.created_at < '2012-06-14'
group by 1

create temporary table session_landing_demo_2



select
sld.website_session_id,
sld.landing_page,
count(wp.website_pageview_id) pages_viewed
from session_landing_demo sld
left join website_pageviews wp on wp.website_session_id=sld.website_session_id
group by 1,2
having count(wp.website_pageview_id) = 1

select min(created_at) from website_pageviews where pageview_url = '/lander-1'


#step1 find the first website_pageview_id for relevant sessions
#step2 identify the landing page of each session
#step3 counting pageviews for each session, to identify "bounces"
#step4 summarizing total sessions and bounced sessions, by LP

drop table T41_1

create table T41_1
select
wp.pageview_url,
wp.website_session_id,
min(wp.website_session_id) minimum
from website_pageviews wp
inner join website_sessions ws on wp.website_session_id=ws.website_session_id
where (pageview_url = '/home' or pageview_url= '/lander-1')
and ws.created_at between '2012-06-19' and '2012-07-28'
and utm_source='gsearch' 
and utm_campaign='nonbrand'
group by 2

select*from t41_1
select
t1.website_session_id min_id,
wp.pageview_url landing_page
from t41_1 t1
inner join website_pageviews wp on wp.website_pageview_id=t1.minimum

#step3 counting pageviews for each session, to identify "bounces"
create table t41_2
select
wp.pageview_url landing_page,
t1.website_session_id
from t41_1 t1
inner join website_pageviews wp on wp.website_session_id=t1.minimum

select*from t41_2
drop table t41_2

create table T41_3
select
t1.website_session_id,
t1.pageview_url,
count(wp.website_pageview_id) pages_viewed
from t41_1 t1
left join website_pageviews wp on wp.website_session_id=t1.website_session_id
group by 1,2
having count(wp.website_pageview_id) = 1

select
t1.pageview_url,
t1.website_session_id,
t2.website_session_id bounced_sessions
from t41_1 t1
left join t41_2 t2 on t2.website_session_id=t1.website_session_id
order by 2


select
t1.pageview_url,
count(t1.website_session_id) sessions,
count(t2.website_session_id) bounced,
count(t2.website_session_id)/count(t1.website_session_id) bounced_rate
from t41_1 t1
left join t41_2 t2 on t2.website_session_id = t1.website_session_id
inner join website_sessions ws on ws.website_session_id=t2.website_session_id
where
utm_source='gsearch' and
utm_campaign='nonbrand'
group by 1


select
count(t1.website_session_id) sessions,
count(bs.website_session_id) bounced_sessions,
count(bs.website_session_id)/count(sld.website_session_id) bounced_rate
from session_landing_demo t1
left join bounced_sessions bs on bs.website_session_id=sld.website_session_id
#group by 1
order by 1




select min(created_at) as first_created_at,
min(website_pageview_id) first_pageview_id
from website_pageviews
where pageview_url ='/lander-1'
and created_at is not null

first_pageview_id=23504

create temporary table first_test_pageviews
select
wp.website_session_id,
min(wp.website_pageview_id) min_pageview_id
from website_pageviews wp
inner join website_sessions ws
on ws.website_session_id=wp.website_session_id
and ws.created_at < '2012-07-28'
and wp.website_pageview_id>23504
and utm_source='gsearch'
and utm_campaign='nonbrand'
group by wp.website_session_id

create temporary table test_sessions
select ftp.website_session_id,
wp.pageview_url landing_page
from first_test_pageviews ftp
left join website_pageviews wp
on wp.website_pageview_id=ftp.min_pageview_id
where wp.pageview_url in ('/home','/lander-1')

select*from test_sessions

drop table bounced_sessions

create temporary table bounced_sessions
select
ts.website_session_id,
ts.landing_page,
count(wp.website_pageview_id) count_of_pages
from test_sessions ts
left join website_pageviews wp on wp.website_session_id = ts.website_session_id
group by 1,2
having count(count_of_pages) =1

select
ts.landing_page,
count(ts.website_session_id),
count(bc.website_session_id) bounced_session,
count(bc.website_session_id)/count(ts.website_session_id) bounced_rate
from test_sessions ts
left join bounced_sessions bc on ts.website_session_id=bc.website_session_id
group by 1
