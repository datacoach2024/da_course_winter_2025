select
	invoice_id
	, customer_id
	, billing_country
	, case billing_country
		when 'Germany' then 'DEU'
		when 'France' then 'FRA'
		when 'Spain' then 'ESP'
		else billing_country
	end as country_code
from invoice;

select
	invoice_id
	, customer_id
	, billing_country
	, case 
		when billing_country in ('USA', 'Canada', 'Mexico') then 'North America'
		when billing_country in ('Brazil', 'Argentina', 'Chile') then 'South America'
		when billing_country in ('India', 'China', 'Australia') then 'Asia'
		else 'Europe'
	end as continent
from invoice;

select
	track_id
	, name as track_name
	, milliseconds
	, case
		when milliseconds / 60000. > 60 then 'over_1h'
		when milliseconds / 60000. > 30 then 'over_30m'
		when milliseconds / 60000. > 10 then 'over_10m'
		else 'below_10m'
	end as duration_bucket
from track;

select
	track_id
	, name as track_name
	, milliseconds
	, case
		when milliseconds / 60000. >= 0 and milliseconds / 60000. < 10 then 'below_10m'
		when milliseconds / 60000. >= 10 and milliseconds / 60000. < 30 then 'over_10m'
		when milliseconds / 60000. >= 30 and milliseconds / 60000. < 60 then 'over_30m'
		when milliseconds / 60000. >= 60 then 'over_60m'
	end as duration_bucket
from track;

drop view v_track;

create view v_track as
select
	track_id
	, name as track_name
	, composer
	, genre_id
	, album_id
	, round(milliseconds / 60000., 2) as duration
	, round(bytes / 1024. / 1024., 2) as size_mb
from track;

select
	case
		when duration > 60 then 'over_1h'
		when duration > 30 then 'over_30m'
		when duration > 10 then 'over_10m'
		else 'less_than_10m'
	end as duration_bucket
	, round(avg(duration), 2) as mean_duration
from v_track
group by
	duration_bucket
;

/*
from
join
where
group by
having
window
select
	case
offset
limit
order
*/

/*
ЗАДАЧА

 Создайте запрос, возвращающий количество трэков в разбивке 
 по названию жанров и по следующим сегментам:
- до 100 мб
- до 500 мб
- до 1000 мб
- более 1000 мб

Результат должен быть отсортирован по названию 
жанра и по баккетам 
*/
with
base as (
	select 
		g.name as genre_name
		, case
			when vt.size_mb > 1000 then 'over_1000mb'
			when vt.size_mb > 500 then 'below_1000mb'
			when vt.size_mb > 100 then 'below_500mb'
			else 'below_100mb'
		end as size_bucket
		, count(track_id) as tracks_cnt
	from v_track vt
		left join genre g on vt.genre_id = g.genre_id
	group by
		g.name
		, size_bucket
)
select *
from base
order by
	genre_name
	, case
		when size_bucket = 'below_100mb' then 1
		when size_bucket = 'below_500mb' then 2
		when size_bucket = 'below_1000mb' then 3
		else 4
	end
;

select 
	a.title 
	, count(vt.track_id) as tracks_cnt
	, count(case when duration > 10 then 1 else null end) as tracks_over_10
from v_track vt
	left join album a on vt.album_id = a.album_id
group by
	a.title
;

select
	track_id
	, track_name
	, composer
	, coalesce(composer, 'unknown') as composer2
from v_track
;