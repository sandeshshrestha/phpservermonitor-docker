FROM php:7.3-apache

LABEL maintainer="info@SandeshShrestha.com"

RUN docker-php-ext-install pdo pdo_mysql sockets \
	&& apt-get update \
	&& apt-get -y install git vim cron zip unzip \
	&& apt-get clean && rm -rf /var/lib/apt/lists/*

RUN set -x \
	&& cd /var/www/html \
	&& rm -rf * \
	&& cd /tmp \
	&& git clone https://github.com/phpservermon/phpservermon \
	&& mv phpservermon/* /var/www/html \
	&& cd /var/www/html \
	&& php composer.phar install \
	&& touch config.php \
	&& chmod 0777 config.php \
	&& cd /usr/local/etc/php \
	&& cp php.ini-production php.ini \
	&& sed -i 's/;date.timezone =/date.timezone = UTC/' php.ini

RUN touch /var/log/cron.log \
        && (crontab -l 2>/dev/null; echo "*/15 * * * * date >> /var//log/cron.log") | crontab - \
        && (crontab -l 2>/dev/null; echo "*/15 * * * * $(which php) /var/www/html/cron/status.cron.php") | crontab -

COPY foreground /usr/local/bin/foreground

EXPOSE 80
EXPOSE 443

CMD ["foreground"]
