import pandas as pd
import plotly
import plotly.express as px
import streamlit as st

# указываем настройки при загрузке
st.set_page_config(layout='wide')

# грузим данные
tips =plotly.data.tips()

days = tips['day'].unique()

# создаём заголовки и добавляем текст
st.title("Streamlit intro")
st.header("Tips analysis")
st.subheader("Tips and total_bills chart")

st.markdown("This is a `demo` of :red[how **markdown**] is :rainbow[rendered]")

st.code("""
    select *
    from track
""", language='sql')

st.text("This is a simple text")

# st.write(days)

# добавляем переклюталь для выбора зоны (курящие/некурящие)
with st.sidebar:
    zone = st.radio('Select zone', options = ['Yes', 'No'])
    gender = st.selectbox('Select gender', options = ['Female', 'Male'])
    days_selected = st.multiselect(
        'Select days', 
        options = days,
        default= days
    )


# фильтруем датафрейм используя значения виджетов
tips_filtered = tips.query(f"smoker == '{zone}' and sex == '{gender}' and day.isin({days_selected})")


# создаём график
fig = px.scatter(
    data_frame = tips_filtered,
    x = 'total_bill',
    y = 'tip'
)

# создаём столбцы
col1, col2 = st.columns(2, gap='large')

with col1:
    # рисуем график
    st.plotly_chart(fig)

with col2:
    # рисуем датафрейм
    st.dataframe(tips_filtered)

st.divider()



# st.table(tips)
