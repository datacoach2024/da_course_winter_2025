# Работа с текстом и датой  

## Работа с текстом  
### Фильтрация текста по шаблонам

Для фильтрации текстовых данных по определенным шаблонам используются следующие операторы:

* **`like`** - чувствителен к регистру
* **`ilike`** - нечувствителен к регистру

Сами шаблоны создаются с помощью подстановочных знаков:

* **`%`** - означает любое количество символов
* **`_`** - означает один символ

```sql
select *
from table
where 
    coll like|ilike pattern
```  

### Склеивание текста  
В SQL можно создать новый текст, склеивая вместе несколько текстовых значений. Это можно сделать разными методами:  
```sql
select 
    coll || delimiter || col2
from table;

select 
    concat(coll, delimiter, col2)
from table;

select 
    concat_ws(delimiter, coll, col2)
from table  
```  

### Длина текста и работа с регистром  
Длина текста определяется функцией length:  
```sql
select 
    length(coll)
from table
```

Изменение регистра текста в нижний и верхний регистр производится функциями `lower` и `upper`. Чтобы сделать заглавной только первую букву текста используется функция `initcap`.  
```sql
select 
    lower|upper|initcap(coll)
from table
```

### Парсинг текста  
Позиция символа в тексте находится функцией `position`:  
```sql
select 
    position(symbol in coll)
from table
```

Для парсинга частей текста используются функции `left`, `right` и `substr`:
```sql
select 
    left|right(coll, sym_cnt)
from table;

select 
    substr(coll, start, sym_cnt)
from table
```
Можно также заменять текст или его часть функцией `replace`:
```sql
select 
    replace(coll, text_to_replace, new_text)
from table
```

### Разбивка текста  
Можно также парсить текст разбивая его на части и вытаскивая нужную часть по индексу:
```sql
select 
    split_part(coll, delimiter, index)
from table;

select 
    (string_to_array(coll, delimiter))[index]
from table
```

### Работа с регулярными выражениями
Большинство современных диалектов также предоставляют возможность использования регулярных выражений при работе с текстом:
```sql
select *
from table
where 
    regexp_like(coll, pattern);

select 
    regexp_substr(coll, pattern)
from table
```

## Работа с датой
### Получение системной даты и времени
Текущую дату и время можно получить с помощью функции `now` либо `localtimestamp`:
```sql
select now() [zone your_timezone];

select localtimestamp
```

Функция `current_date` возвращает текущую дату без указания времени. А функция `current_time` наоборот возвращает только текущее время.
```sql
select current_date|current_time
from table
```

### Интервал
PostgreSQL возвращает разницу между двумя датами в виде специального типа данных, называемого *interval*. По умолчанию разница между датами возвращается в днях. Можно получить разницу в годах, используя функцию `age`.
```sql
select date1 - date2;

select age(end_date, start_date)
```

### Парсинг дат и усечение
Функция `extract` возвращает указанную часть даты.
```sql
select extract(part_of_date from some_date)
```

Также даты можно усечь (т.е. округлить вниз) до указанного периода с помощью функции `date_trunc`. При этом требуемый период нужно указывать в кавычках.
```sql
select date_trunc(period, some_date)
```

### Создание дат
Для создания дат в PostgreSQL существует группа функций с префиксом *make*:
```sql
select make_date(year, month, day);

select make_time(hour, minute, second(double precision));

select make_timestamp(year, month, day, hour, minute, second(double precision));

select make_interval(years [, months [, days [, hours [, mins [,secs (d b)]]]]] )
```

### Конвертация типов
При необходимости дату можно конвертировать в текстовый формат функцией `cast`:
```sql
select cast(some_date as text);

select some_date::text
```
Также существует функция `to_char` позволяющая конвертировать дату в текст в нужном формате:
```sql
select to_char(some_date, format)
```