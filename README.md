GeoDjango + Docker Compose

Этот проект использует GeoDjango для работы с геоданными. Развертывание осуществляется через Docker Compose с поддержкой PostGIS.

Запуск проекта

1. Клонирование репозитория

git clone https://github.com/madalbekovich/GrandSystem.git

cd GrandSystem

2. Создание .env файла

Создайте файл .env в корне проекта и добавьте переменные окружения:

DJANGO_SECRET_KEY=your_secret_key

DEBUG=True

POSTGRES_DB=geodjango

POSTGRES_USER=admin

POSTGRES_PASSWORD=admin

POSTGRES_HOST=db

POSTGRES_PORT=5432


3. Запуск контейнеров

docker-compose up --build

Это создаст и запустит контейнеры с GeoDjango и базой данных PostGIS.

4. Применение миграций

docker-compose exec web python manage.py migrate

5. Создание суперпользователя

docker-compose exec web python manage.py createsuperuser

6. Открытие проекта в браузере

После успешного запуска проект будет доступен по адресу:

http://localhost:8000/


TAGS: Postgis Posgresql GDAL и GEOS, 

