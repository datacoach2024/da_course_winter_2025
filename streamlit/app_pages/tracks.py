import pandas as pd
from sqlalchemy import text
import streamlit as st
import time

from connect import set_connection

# используем декоратор чтобы данные streamlit каждый раз не загружал данные из БД
@st.cache_data
def get_tracks(number_of_rows):
    # создаём запрос
    query = f"""
    select 
        t.track_id
        , t.name as track_name
        , t.composer
        , g.name as genre_name
    from track t
        left join genre g
            on t.genre_id = g.genre_id
    limit {number_of_rows}
    """

    # подключаемся к БД и вытаскиваем данные
    with set_connection() as conn:
        time.sleep(5)  # имитируем задержку из-за получения данных с удалённого сервера
        df = pd.read_sql(query, conn)

    return df

# создаём виджет для выбора пользователем количества выгружаемых строк
number_of_rows = st.sidebar.slider(
    'Select number of rows to fetch',
    min_value=1000,
    max_value=5000
)

# создаём датафрейм
if st.checkbox('Fetch data'):
    tracks = get_tracks(number_of_rows)

    # вытаскиваем список уникальных названий жанров
    genres = tracks['genre_name'].unique()


    # создаём виджет для выбора пользователем списка жанров
    genres_selected = st.sidebar.multiselect(
        'Select genre', 
        options=genres, 
        default=genres
    )


    # фильтруем датафрейм по названиям жанров
    tracks_filtered = tracks.query(f"genre_name.isin({genres_selected})")


    # отображаем датафрейм
    st.dataframe(tracks_filtered)


