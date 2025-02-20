-- ОПЕРАТОРЫ СОЧЕТАНИЙ (СЕТОВЫЕ)

create table tr1 as
select
	track_id
	, name
from track
limit 5;

create table tr2 as
select
	track_id
	, name
from track
limit 5
offset 2;


select *
from tr1
union all
select *
from tr2;

select *
from tr1
union
select *
from tr2
order by
	track_id;
	
select *
from tr1;

select *
from tr2;

update tr2
set name = 'APT'
where
	track_id = 4;

select *
from tr1
union
select *
from tr2
order by track_id;

select *
from tr1
intersect
select *
from tr2;

select *
from tr1
except
select *
from tr2;

-- ДЖОЙНЫ
select *
from tr1
	left join tr2 
		on tr1.track_id = tr2.track_id
		
/*
ОЧЕРЕДЬ ВЫПОЛНЕНИЯ
1. from
2. join
3. where
4. group by
5. having
6. select
7. offset
8. limit
 */
select *
from tr1
	right join tr2
		on tr1.track_id = tr2.track_id
;

select *
from tr1
	inner join tr2
		on tr1.track_id = tr2.track_id
;

select *
from tr1
	full join tr2
		on tr1.track_id = tr2.track_id
;

select
	t.track_id
	, t.name as track_name
	, g.name as genre_name
from track t
	left join genre g
		on t.genre_id = g.genre_id
;

/*
ЗАДАЧА
1. вытащить данные содержащие следующие столбцы:
* customer_id
* full_name (first_name and last_name)
* total
и посчитать общую сумму чеков в разбивке по клиентам
*/

select
	i.customer_id
	, concat_ws(' ', c.first_name, c.last_name) as full_name
	, sum(i.total) as total_sum
from invoice i
	left join customer c
		on i.customer_id = c.customer_id
group by
	i.customer_id
	, concat_ws(' ', c.first_name, c.last_name)
;

update tr2
set track_id = 3
where
	name = 'APT';

update tr2
set track_id = 5
where
	track_id = 7;

select *
from tr2;

select *
from tr1;

select *
from tr1
	left join tr2
		on tr1.track_id = tr2.track_id
;
-- self join
select
	e1.employee_id
	, e1.last_name
	, count(e2.employee_id) as subordinates_cnt
from employee e1
	left join employee e2
		on e1.employee_id = e2.reports_to
group by
	e1.employee_id
	, e1.last_name
order by
	e1.employee_id
;

select
	e1.employee_id
	, e1.last_name
	, e2.employee_id as subordinates
from employee e1
	left join employee e2
		on e1.employee_id = e2.reports_to
order by
	e1.employee_id
;

-- anti join
select
	t.track_id
	, t.name
	, t.unit_price
	, il.track_id
from track t
	left join invoice_line il
		on t.track_id = il.track_id
where
	il.track_id is null;
	

select
	t.track_id
	, t.name
from track t
where
	t.track_id in (
		select track_id
		from invoice_line
	)
;


-- SEMI JOIN
select
	t.track_id
	, t.name
from track t
where  
	exists (
		select 1
		from invoice_line il  
		where
			il.track_id = t.track_id
	)
;

create table years (
	rep_year integer
);

create table months (
	rep_month integer
);
insert into years 
with
recursive years_cte(y) as (
	select 2025
	union all
	select y + 1
	from years_cte
	where
		y < 2030
)
select y as rep_year
from years_cte
order by y;

select *
from years;

insert into months
with
recursive months_cte(m) as (
	select 1
	union all
	select m + 1
	from months_cte
	where
		m < 12
)
select m as rep_month
from months_cte
order by m;

create table calendar as
select
	y.rep_year
	, m.rep_month
from years y
	cross join months m
order by
	y.rep_year
	, m.rep_month
;

select *
from calendar;

select
	t1.track_id as track_id1
	, t1.name as name1
	, t2.track_id as track_id2
	, t2.name as name2
from track t1
	inner join track t2
		on t1.track_id != t2.track_id
;

create table colors (
	color text
);

insert into colors
values ('white'), ('black'), ('green'), ('red');

select *
from colors c1
	inner join colors c2 on c1.color > c2.color
;

with
recursive dates_range(stime, etime) as (
	select
		make_timestamp(2025, 1, 1, 0, 0, 0)
		, make_timestamp(2025, 1, 10, 0, 0, 0)
	union all
	select
		etime + make_interval(days=>1) as stime
		, etime + make_interval(days=>10) as etime
	from dates_range
	where
		etime < make_timestamp(2025, 1, 31, 0, 0, 0)
)
select
	dr.stime
	, dr.etime
	, sum(i.total) as total_sum
from dates_range dr
	left join invoice i
		on i.invoice_date between dr.stime and dr.etime
group by
	dr.stime
	, dr.etime
order by
	dr.stime