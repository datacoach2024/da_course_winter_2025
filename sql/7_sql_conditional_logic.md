# Условная логика в SQL  
Условная логика позволяет выполнять различные операции в зависимости от того, выполняются или нет определенные условия. В SQL для этого используются `case` выражения.  

## Синтаксис 1-й формы  

```sql
select
    case <column>
        when <value1> then <result1>
        when <value2> then <result2>
        [else <result_else>]
    end
from <table>
```  

В этой форме `case` сравнивает значение `column` с `value1`, `value2` и т.д. Если совпадение найдено, возвращается соответствующий `result`. Если совпадений нет, возвращается `result_else` (если он указан, иначе возвращается `null`).  

**Пример**. Допустим, у нас есть таблица **Products** со столбцами `product_id`, `product_name` и `category`. Мы хотим вывести название продукта и его категорию. Но если категория - *Electronics*, мы хотим вывести *Tech*.  

```sql
select
    product_name
    , case category
        when 'Electronics' then 'Tech'
        else category 
    end
from products
```  

## Синтаксис 2-й формы  

```sql
select
    case
        when <condition1> then <result1>
        when <condition2> then <result2>
        [else <result_else>]
    end
from <table>
```

В этой форме `case` проверяет каждое условие и возвращает результат только для первого выполненного условия. Если ни одно из условий не выполняется, возвращается `result_else` (если он указан).  

**Пример**. Допустим, у нас есть таблица **Orders** со столбцами `order_id` и `total_amount`. Мы хотим вывести `order_id` и статус заказа - *high* для заказов с `total_amount > 100`, *medium* для заказов с `total_amount > 50` и *low* для остальных заказов.  

```sql
select
    order_id
    , case
        when total_amount > 100 then 'high'
        when total_amount > 50 then 'medium'
        else 'low'
    end
from <table>
```

## Использование выражения `case` с агрегирующими функциями  

Комбинируя выражение `case` с агрегирующими функциями мы можем создавать вычисления по условию. 

**Пример**. Для таблицы **Orders** посчитаем среднюю сумму заказа для каждого клиента, а также отдельно, среднюю сумму для заказов с суммой больше 50.  

```sql
select
    customer_id
    , avg(total_amount) as avg_amount
    , avg(case when total_amount > 50 then total_amount else null end) as avg_high_amount
from orders
group by
    customer_id
```  

## Проверка на `null`  

Функция `coalesce` список переданных ей аргументов и возвращает первое не-`null` значение.

```sql
coalesce(<value1>, <value2>[, <value3>, ...])
```



