# Використовуємо Python 3.9
FROM python:3.11-slim

# Задаємо робочий каталог
WORKDIR /code

# Копіюємо requirements.txt і встановлюємо залежності
COPY requirements.txt /code/
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# Копіюємо весь код проєкту
COPY . /code/

# Міграції (опційно можна запускати окремо)
# RUN python manage.py migrate

# Запуск
CMD ["gunicorn", "myproject.wsgi:application", "--bind", "0.0.0.0:8000"]