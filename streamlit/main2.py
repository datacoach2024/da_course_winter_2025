import streamlit as st

st.set_page_config(layout='wide')

st.title("My First Dashboard")

# создаём страницы для каждого из модулей в папке 'app_pages'
tips_page = st.Page(
    "app_pages/tips.py", 
    title='🍽️ Tips',
    default=True  # делаем страницей по умолчанию, т.е. эта страница всегда будет отображаться первой
)
stocks_page = st.Page("app_pages/stocks.py", title='💹 Stocks')
tracks_page = st.Page("app_pages/tracks.py", title='🎧 Tracks')

# создаём навигацию по страницам
pgs = st.navigation([tips_page, stocks_page, tracks_page])
pgs.run()