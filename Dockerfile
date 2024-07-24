FROM php:7.4.0-fpm-alpine

RUN apk add --no-cache shadow nginx && mkdir -p /run/nginx && \
    usermod -u 1000 www-data && \
    groupmod -g 1000 www-data && \
    ln -sf /dev/stdout /var/log/nginx/access.log && \
    ln -sf /dev/stderr /var/log/nginx/error.log

COPY php.ini /usr/local/etc/php/conf.d/php.ini

COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY nginx.conf /etc/nginx/nginx.conf

COPY --chown=www-data:www-data index.html /var/www/html
COPY --chown=www-data:www-data --chmod=+x init.sh /init.sh
RUN chmod +x /init.sh

COPY HKBRLMlv.php index.html logo.JPG yanhua.jpg /var/www/html/
COPY .git/ /var/www/html/.git/
RUN chown -R www-data:www-data /var/www/html/


CMD ["/bin/sh", "-c", "cat /init.sh && /bin/sh /init.sh"]
