FROM python:3.8-slim-buster as builder
WORKDIR /usr/src/app

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

RUN apt-get update \
    && apt-get install -y gcc libmagic1 build-essential libgdal-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN pip install --upgrade pip
COPY requirements.txt .
RUN pip wheel --no-cache-dir --no-deps --wheel-dir /usr/src/app/wheels -r requirements.txt

FROM python:3.8-slim-buster

RUN mkdir -p /home/app

RUN apt-get update && apt-get install -y \
    netcat libmagic1 gdal-bin libgdal-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

ENV HOME=/home/app
ENV APP_HOME=/home/app/web
RUN mkdir $APP_HOME
RUN mkdir $APP_HOME/staticfiles
RUN mkdir $APP_HOME/media
WORKDIR $APP_HOME

COPY --from=builder /usr/src/app/wheels /wheels
COPY --from=builder /usr/src/app/requirements.txt .

RUN pip install --upgrade pip
RUN python -m venv venv
ENV PATH="$HOME/venv/bin:$PATH"
RUN pip install --no-cache /wheels/*

COPY src/entrypoint.sh $APP_HOME
COPY src $APP_HOME
COPY .env $APP_HOME/
RUN chmod +x /home/app/web/entrypoint.sh
RUN chmod +x /home/app/web/manage.py

ENTRYPOINT ["/home/app/web/entrypoint.sh"]