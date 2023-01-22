FROM nginx:1.23.2-alpine

COPY ./common/nginx/snippets /etc/nginx/snippets
COPY ./development/nginx/conf.d /etc/nginx/conf.d

WORKDIR /app