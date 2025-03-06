import pandas as pd
import plotly
import streamlit as st

# создаём датафрейм на основе датасета `stocks`
stocks = plotly.data.stocks()

# вытаскиваем минимальную и максимальную дату из датафрейма для создания виджета
min_date, max_date = stocks['date'].agg(['min', 'max'])

with st.sidebar:
    # создаём виджет для выбора даты
    date_selected = st.date_input(
        'Select maximum date',
        min_value=min_date,
        max_value=max_date,
        value=max_date
    )

# создаём фильтр
filter = f"date <= '{date_selected}'"

# создаём отфильтрованный датафрейм
stocks_filtered = stocks.query(filter)

# отображаем датафрейм
st.dataframe(
    stocks_filtered,
    width=2000
)