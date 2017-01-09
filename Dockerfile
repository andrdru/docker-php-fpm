FROM php:fpm

RUN apt-get update

# Install Git
RUN apt-get install -y git

# Install Postgre PDO
RUN apt-get install -y libpq-dev
RUN docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql

#Install curl
RUN apt-get install -y curl libcurl3 libcurl3-dev

#Install International Components for Unicode
RUN apt-get install -y libicu-dev

#ssl libs
RUN apt-get install -y libc-client-dev libkrb5-dev

#lib for gd
RUN apt-get install -y libpng-dev

#mail support
RUN apt-get install -y exim4

#Configure imap
RUN docker-php-ext-configure imap --with-imap-ssl --with-kerberos

#gettext
RUN apt-get install -y php5-intl gettext locales locales-all

#install docker php extention
RUN docker-php-ext-install \
        mysqli \
        pdo \
        pdo_pgsql \
        pgsql \
        intl \
        exif \
        pcntl \
        gettext \
        imap \
        ftp \
        gd \
        json \
        curl \
        iconv \
        mbstring


#add sendmail to php
RUN echo "sendmail_path=sendmail -i -t" >> /usr/local/etc/php/conf.d/php-sendmail.ini

#cleanup
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#new entrypoint
COPY entrypoint.sh /usr/local/bin/

RUN chmod 777 /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh\"]