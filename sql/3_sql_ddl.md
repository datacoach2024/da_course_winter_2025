# Создание, редактирование и удаление таблиц в базах данных

Сегодня мы рассмотрим процесс создания, редактирования и удаления таблиц в базах данных, а также некоторые другие важные концепции.

## Основные типы данных
Перед тем как создавать таблицы, важно понимать основные типы данных, которые можно использовать для определения столбцов таблицы.
* **boolean**: 1 байт, значения true или false.
* **char(n)**: n + 1 байт, символы фиксированной длины от 1 до 8,000.
* **varchar(n)**: фактическая длина + 1 байт, символы переменной длины от 1 до 8,000.
* **text**: фактическая длина + 1 байт, символы без ограничений.
* **smallint**: 2 байта, целые числа от -32,768 до 32,767.
* **integer**: 4 байта, целые числа от -2,147,483,648 до 2,147,483,647.
* **bigint**: 8 байт, большие целые числа от -9,223,372,036,854,775,808 до 9,223,372,036,854,775,807.
* **serial**: 4 байта, целое число (аналогично integer).
* **decimal(p, s)**: переменная длина, десятичные числа с заданной точностью.
* **numeric(p, s)**: переменная длина, числовые значения с заданной точностью.
* **real**: 4 байта, числа с плавающей точкой.
* **date**: 4 байта, даты от 4713 BC до 5874897 AD.
* **time**: 8 байт, время.
* **timestamp**: 8 байт, временная отметка от 4713 BC до 5874897 AD.
* **interval**: переменная длина, временной интервал от -178000 до 178000 лет.

## Создание и выбор схемы
Схема - это пространство имен для объектов базы данных, таких как таблицы.

* Для создания схемы используется команда:  
```sql
create schema [if not exists] <schema_name>
```
* Чтобы выбрать схему, используется команда:  
```sql
set search_path to <schema_name>
```

## Создание таблиц
Таблицы создаются с использованием команды `create table`.

* Синтаксис создания таблицы: 
```sql
create table [if not exists] <table_name> (
    <column1> <datatype(length)> <column_constraint>
    , <column2> <datatype(length)> <column_constraint>
    , ...  
    , <table_constraints>
)
```
* Можно также создать таблицу на основе результатов запроса:  
```sql
create table [if not exists] <table_name> as <query>
```

## Атрибуты столбцов
При создании таблиц можно задать различные атрибуты для столбцов:

* **auto_increment**: автоматическое увеличение значения при добавлении новых записей.
* **unique**: все значения в столбце должны быть уникальными.
* **not null**: столбец не может содержать пустые значения.
* **default**: значение по умолчанию.
* **check**: проверка значения на соответствие условию.
* **primary key**: используется для указания первичного ключа.
* **foreign key**: используется для указания внешнего ключа.

## Добавление данных
Данные добавляются в таблицу с помощью команды `insert into`.

* Синтаксис добавления данных:  
```sql
insert into [if not exists] <table_name> (<column1>, ...) 
values 
    (<value1>, ...)
    [, (<value2>, ...)]
```
* Также можно добавить данные на основе результатов запроса:  
```sql
insert into [if not exists] <table_name> (<column1>, ...) 
<query>
```

## Изменение данных
Данные в таблице можно изменять с помощью команд `update` и `delete`.

* для изменения значений:  
```sql
update <table_name> 
set <column1>=<value1> 
    [, <column2>=<value2>] 
[where <condition>]
```
* для удаления строк:
```sql
delete from table_name 
where <condition>
```

## Изменение структуры таблицы
Структуру таблицы можно изменять с помощью команды `alter table`.
* переименование таблицы: 
```sql
alter table <table_name> 
rename to <new_table_name>
```
* добавление нового столбца:  
```sql
alter table <table_name> 
add column <new_table_name> <data type>
```
* удаление столбца: 
```sql
alter table <table_name> 
drop column <column_name>
```

## Опустошение и удаление таблиц
Для удаления всех данных из таблицы используется команда `truncate`. Для удаления таблицы используется команда `drop table`.
* опустошение таблицы: 
```sql
truncate table <table_name> [restart identity] [cascade]
```
* удаление таблицы: 
```sql
drop table <table_name> [cascade]
```

## Создание и удаление индекса
Индексы используются для ускорения поиска данных.

* создание индекса: 
```sql
create index <index_name> on <table_name>(<column_name>)
```
* удаление индекса: 
```sql
drop index <index_name>
```

## Создание и удаление представления
Представления (*views*) - это сохраненные запросы, которые можно использовать как виртуальные таблицы.
* создание представления: 
```sql
create [or replace] [if not exists] <view_name> as <query>
```
* удаление представления: 
```sql
drop view <view_name> [cascade]
```

# Работа с базой данных через Python
Для работы с базой данных через *Python* используется библиотека *SQLAlchemy*.  

## Виртуальное окружение  
Для каждого проекта создается изолированная среда.  

Создание виртуального окружения: 
```bash
python -m venv .venv
```
Активация виртуального окружения: 
```bash
.venv/Scripts/activate
```

Если выйдет ошибка типа *"Невозможно загрузить файл ... так как выполнение сценариев отключено в этой системе"*, используйте следующую команду:  
```shell
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Unrestricted
``` 

## Подключение к базе данных    
Импортируем библиотеку: 
```python
import sqlalchemy as db
```
Строка подключения: 
```python
connection_string = 'postgresql://username:password@host:5432/database'
```
Создание движка: 
```python
engine = db.create_engine(connection_string)
```
Подключение к базе данных: 
```python
conn = engine.connect()
```  

Иногда подключение с использованием строки может не сработать. В таком случае, можно попробовать создать подключение используя метод `URL`.  
```python
from sqlalchemy.engine import URL  

connection_url = URL.create(
    drivername="postgresql+psycopg2",
    username = user,
    password = password,
    host = host,
    port = port
)  

engine = create_engine(connection_url)
conn = engine.connect()
```  
