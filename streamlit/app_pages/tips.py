import pandas as pd
import plotly
import plotly.express as px
import streamlit as st

# создаём датафрейм из датасета `tips`
tips = plotly.data.tips()

# вытаскиваем список уникальных значений для добавления вариантов выбора в виджеты
zone_options = list(tips['smoker'].unique()) + ['All']
gender_options = list(tips['sex'].unique()) + ['All']
days_options = tips['day'].unique()
min_bill, max_bill = tips['total_bill'].agg(['min', 'max'])
min_size, max_size = tips['size'].agg(['min', 'max'])


# создаём боковую панель с виджетами
with st.sidebar:
    zone = st.radio('Select zone', options=zone_options)
    gender = st.selectbox('Select gender', options=gender_options)
    days_selected = st.multiselect(
        'Select days', 
        options=days_options,
        default=days_options
    )
    min_bill_selected, max_bill_selected = st.slider(
        'Select bills range',
        min_value=min_bill,
        max_value=max_bill,
        value=(min_bill + 20, max_bill - 10)
    )
    table_size = st.number_input(
        'Select table size',
        min_value=min_size,
        max_value=max_size,
        value=max_size
    )


# создаём отдельные фильтры по результатам взаимодействия пользователя с виджетами
zone_filter = f"smoker {'!=' if zone == 'All' else '=='} '{zone}'"
gender_filter = f"sex {'!=' if gender == 'All' else '=='} '{gender}'"
days_filter = f"day.isin({days_selected})"
bills_filter = f"total_bill.between({min_bill_selected}, {max_bill_selected})"
size_filter = f"size <= {table_size}"

# объединяем все фильтры в один
filter = f"{zone_filter} and {gender_filter} and {days_filter} and {bills_filter} and {size_filter}"

# создаём отфильтрованный датафрейм
tips_filtered = tips.query(filter)

# создаём столбцы
col1, col2 = st.columns(2, gap='medium')

# в первом столбце отображаем датафрейм
with col1:
    st.dataframe(tips_filtered)

# во втором столбце отображаем диаграмму
with col2:
    # если поставлена галочка
    if st.checkbox('Show the chart'):
        fig = px.scatter(
            data_frame=tips_filtered,
            x='total_bill',
            y='tip'
        )

        st.plotly_chart(fig)