FROM cicd-app-prod:hot as app

FROM nginx:stable-alpine
COPY --from=app /var/www/html/public /usr/share/nginx/html/
