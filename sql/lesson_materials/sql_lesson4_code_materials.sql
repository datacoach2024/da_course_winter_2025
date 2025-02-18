-- ПОДЗАПРОСЫ  
select avg(milliseconds)
from track;
-- 393 599.21

select
	track_id
	, name
	, milliseconds
from track
where
	milliseconds > (
		select avg(milliseconds)
		from track
	)
order by
	milliseconds
;

select *
from track;

select *
from genre;

select *
from track
where
	genre_id in (
		select 
			genre_id
		from genre
		where
			name ilike '%r%'
	);

select
	invoice_id
	, customer_id
	, invoice_date
	, total
	, round(total /(select sum(total) from invoice), 4) as pct_of_total_sum
from invoice;

select *
from (
	select
		track_id
		, name as track_name
		, round(milliseconds/60000., 2) as duration_in_min
	from track
)
where
	duration_in_min > 5
order by
	duration_in_min;

/*
ЗАДАЧКИ 

1. Рассчитайте среднее количество треков на один жанр
2. Найдите максимальную длину полного имени клиентов
*/
select avg(tracks_cnt)
from (
	select
		genre_id
		, count(track_id) as tracks_cnt
	from track
	group by
		genre_id
);

select max(name_length)
from (
	select
		length(concat_ws(' ', first_name, last_name)) as name_length
	from customer
);

select
	track_id
	, name as track_name
	, genre_id
	, milliseconds
	, (
		select
			round(avg(milliseconds), 2)
		from track t2
		where
			t2.genre_id = t1.genre_id
	) as genre_average
from track t1;

with
base as (
	select
		track_id
		, name as track_name
		, genre_id
		, round(milliseconds / 60000., 2) as duration
	from track
)
, by_genres as (
	select
		genre_id
		, avg(duration) as genre_avg
	from base
	group by
		genre_id
)
select
	track_id
	, track_name
	, genre_id
	, duration
	, (
		select round(genre_avg, 2)
		from by_genres bg
		where
			bg.genre_id = b.genre_id
	)
from base b;

