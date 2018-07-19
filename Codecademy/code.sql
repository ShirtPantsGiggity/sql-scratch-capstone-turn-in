select count(distinct utm_campaign) as 'Campaign Count'
from page_visits;

___________________________________________________________________________________________
select count(distinct utm_source) as 'Source Count'
from page_visits;


___________________________________________________________________________________________
select distinct utm_campaign as Campaigns,
utm_source as Sources
from page_visits;


___________________________________________________________________________________________
select distinct page_name as 'Page Names'
from page_visits;


___________________________________________________________________________________________
with first_touch as (select user_id, min(timestamp) as first_touch_at
from page_visits
group by user_id),

ft_attr as (select ft.user_id, ft.first_touch_at, pv.utm_source, pv.utm_campaign
from first_touch ft

join page_visits pv
on ft.user_id = pv.user_id
and ft.first_touch_at = pv.timestamp)

select ft_attr.utm_source as Source, ft_attr.utm_campaign as Campaign, count(*)
from ft_attr
group by 1, 2
order by 3 desc;


___________________________________________________________________________________________
with last_touch as (select user_id, max(timestamp) as last_touch_at
from page_visits
group by user_id),

lt_attr as (select lt.user_id, lt.last_touch_at, pv.utm_source, pv.utm_campaign
from last_touch lt

join page_visits pv
on lt.user_id = pv.user_id
and lt.last_touch_at = pv.timestamp)

select lt_attr.utm_source as Source, lt_attr.utm_campaign as Campaign, count(*)
from lt_attr
group by 1, 2
order by 3 desc;


___________________________________________________________________________________________
select count(distinct user_id) as 'Customers with Purchase'
from page_visits
where page_name = '4 - purchase';


___________________________________________________________________________________________
with last_touch as (select user_id, max(timestamp) as last_touch_at
from page_visits
where page_name = '4 - purchase'
group by user_id),

lt_attr as (select lt.user_id, lt.last_touch_at, pv.utm_source, pv.utm_campaign
from last_touch lt

join page_visits pv
on lt.user_id = pv.user_id
and lt.last_touch_at = pv.timestamp)

select lt_attr.utm_source as Source, lt_attr.utm_campaign as Campaign, count(*)
from lt_attr
group by 1, 2
order by 3 desc;