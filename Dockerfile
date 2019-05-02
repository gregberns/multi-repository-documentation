FROM python:3.6.4-alpine3.7@sha256:10bd7a59cfac2a784bedd1e6d89887995559f00b61f005a101845ed736bed779 as build

RUN apk add --no-cache enchant make

WORKDIR /home/python

RUN mkdir docs 

ENV PIP_DISABLE_PIP_VERSION_CHECK True
ENV PIP_NO_CACHE_DIR False
ENV PYTHONUNBUFFERED True

COPY requirements.pip ./

RUN python -m pip install --requirement requirements.pip \
    && pip install --upgrade recommonmark

COPY index.rst .
COPY conf.py .
COPY Makefile .
COPY repos/ ./repos

RUN sphinx-build -b html /home/python /home/python/_build/html

FROM nginx:alpine as run

COPY default.conf /etc/nginx/conf.d/default.conf
COPY --from=build /home/python/_build/html /usr/share/nginx/html
