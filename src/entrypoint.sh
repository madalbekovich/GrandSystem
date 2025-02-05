#!/bin/sh
export DJANGO_SETTINGS_MODULE=config.settings
if [ "$DATABASE" = "postgres" ]; then
    echo "Ждем, ждем..."

    while ! nc -z "$POSTGRES_HOST" "$POSTGRES_PORT"; do
        sleep 0.1
        echo "Postgres не доступно - ждем..."
    done

    echo "Postgres работает)"
fi
python manage.py collectstatic --noinput
python manage.py migrate
echo "ВСЕ ОК"
exec "$@"