FROM python:3.7-alpine
MAINTAINER Nurbek Batyrzhan

ENV PYTHONUNBUFFERED 1

RUN mkdir /code
WORKDIR /code
COPY ./bboard /code/bborad
COPY ./sampleproject /code/sampleproject
COPY ./.gitignore /code/.gitignore
COPY ./manage.py /code/manage.py
COPY ./Pipfile /code/Pipfile

RUN pip3 install pipenv

ONBUILD COPY Pipfile Pipfile
ONBUILD COPY Pipfile.lock Pipfile.lock

ONBUILD RUN set -ex && pipenv install --deploy --system
#RUN pipenv install --system --deploy --ignore-pipfile
# run Django
CMD [ "python", "./manage.py", "runserver", "0.0.0.0:8000"]

