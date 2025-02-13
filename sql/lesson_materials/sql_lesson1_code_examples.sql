-- однострочный комментарий  

/*
Многострочный 
комментарий
*/

select
	track_id 
	, name 
	, composer 
	, album_id
from track;

select 9/3;

select 9/4.;

select
	name as track_name
	, round(milliseconds / 60000., 2) as duration_in_min
from track
;

select round(6590, -2);

select *
from track
order by
	name desc
	, track_id desc
;

select *
from track
order by 
	track_id desc
limit 10;

select *
from track
limit 10
offset 10

/*
Порядок обработки команд со стороны СУБД:
1 from
2 select
3 offset
4 limit
*/

select *
from track
where
	album_id != 3
;

select *
from track
where
	composer = 'Queen'
	or composer = 'U2'
	or composer = 'AC/DC'
	or composer = 'Pink Floyd'
;

select *
from track
where
	composer in ('Queen', 'AC/DC', 'U2', 'Linkin Park')
;

select *
from track
where
	composer = 'Queen'
	and bytes > 9000000
;

select *
from track
where
	composer = 'Queen'
	or composer = 'AC/DC'
order by 
	bytes
;

select *
from track
where
	bytes > 9000000
	and (composer = 'Queen'
	or composer = 'AC/DC')
;

select *
from track
where
	composer is not null
;

select 
	sum(total)
	, avg(total)
	, min(total)
	, max(total)
	, count(customer_id)
	, count(distinct customer_id)
from invoice;

select 
	distinct customer_id
from customer;

select distinct
	country
	, state
from customer;

select 
	country
	, count(customer_id) as customer_cnt
from customer
group by
	country
;

/*
1. from
2. where
3. group by
4. select
5. offset
6. limit
*/

select 
	country
	, count(customer_id) as customer_cnt
from customer
where
	country != 'USA'
group by
	country
having
	count(customer_id) > 2
order by
	customer_cnt desc
;

select 
	country
	, state
	, count(customer_id) as customer_cnt
from customer
group by
	country
	, state
;