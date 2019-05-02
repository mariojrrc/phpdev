FROM juliangut/phpdev:7.2-fpm
MAINTAINER Mario Costa <mariojr.rcosta@gmail.com>

RUN apk add --no-cache \
		$PHPIZE_DEPS \
		openssl-dev
RUN apk update && DEBIAN_FRONTEND=noninteractive apk add curl git vim unzip libxslt-dev bzip2-dev gettext-dev icu-dev postgresql-dev libmemcached-dev

RUN docker-php-ext-install bz2 calendar fileinfo gettext intl mysqli pcntl pdo_mysql pdo_pgsql pgsql soap xsl zip \
&& pecl install mongodb redis memcached \
&& docker-php-ext-enable mongodb redis memcached

RUN composer global require --prefer-dist phpunit/phpunit phpmd/phpmd pdepend/pdepend sebastian/phpcpd squizlabs/php_codesniffer theseer/phpdox phploc/phploc phing/phing mayflower/php-codebrowser codeception/codeception robmorgan/phinx

VOLUME /var/www/html /var/log/php
WORKDIR /var/www/html
