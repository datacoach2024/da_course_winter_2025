select *
from track
where
	composer = 'Queen'
;

select *
from track
where
	name like 'K%'
;

select *
from track
where
	name like '_%K%'
;

select *
from track
where
	name ilike '%k%'
;

select *
from customer
where
	last_name like 'K_hler';

select *
from customer
where
	address ilike '%-Stra_e%'
;

select
	customer_id
	, country
	, state
	, city
	, country || ' ' || state || ' ' || city as address
	, concat(country, ' ', state, ' ', city) as address2
	, concat_ws(', ', country, state, city) as address3
from customer;

select
	name
	, length(name) as title_len
from track;

select
	name
	, upper(name) as all_caps
	, lower(name) as all_lower
	, initcap(name) as each_word_cap
from track
;

select
	name
	, left(name, 3) as first3_symbols
	, right(name, 2) as last2_symbols
	, substring(name, 2, 4) as middle_symbols
from track;

select
	name
	, position('n' in name) as n_ix
from track;

select replace('AIAcademy', 'AI', 'Artificial Intelligence ');

select
	name
	, replace(name, 'Shark', 'Baby Shark')
from track;

select
	employee_id
	, email
	, split_part(email, '@', 2) as domain_name
	, (string_to_array(email, '@'))[1] as email_arr
from employee;  

select
	name
	, regexp_substr(name, '\d{4}') as year_in_track_name
from track
where
	regexp_like(name, '\d');
	
select *
from track
where
	regexp_like(name, '^S')
;

select *
from track
where
	regexp_like(name, 'm$', 'i')
;

select *
from track
where
	regexp_like(name, '^[^K].*')
;

select
	name
	, regexp_substr(name, '\d{1,3}')
from track
where
	regexp_substr(name, '\d') is not null
;

-- РАБОТА С ДАТОЙ И ВРЕМЕНЕМ
select now();

select localtimestamp;

select current_date;

select current_time, current_timestamp;

select
	pg_typeof(current_date)
	, pg_typeof(localtimestamp)
	, pg_typeof(current_time)
;

select
	employee_id
	, hire_date
	, localtimestamp - hire_date
	, age(localtimestamp, hire_date) as diff_in_years
	, extract('year' from age(localtimestamp, hire_date)) as years
	, floor(extract('day' from localtimestamp - hire_date)/30.4) as diff_in_months
	, pg_typeof(localtimestamp - hire_date) as diff_type
from employee;

select 
	employee_id
	, hire_date
	, extract('year' from hire_date) as hire_year
	, extract('month' from hire_date) as hire_month
	, to_char(hire_date, 'month') as hire_monthname
	, to_char(hire_date, 'day') as hire_dayname
	, cast(to_char(hire_date, 'YYYYMM') as integer) as monthkey
	, to_char(hire_date, 'YYYYMM')::integer as monthkey_int
from employee;

select
	make_date(2020, 4, 12)
	, make_timestamp(2020, 4, 12, 16, 24, 3.23)
	, make_interval(days=>5)
;

select
	localtimestamp
	, date_trunc('day', localtimestamp)
	, date_trunc('month', localtimestamp)
	, date_trunc('year', localtimestamp)
	, date_trunc('month', localtimestamp) - make_interval(days=>1)
--from employees