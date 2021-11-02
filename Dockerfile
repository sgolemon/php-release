# Build PHP releases with ease
# Based on dshafik/php-build, but removes interactivity requirement

# Build with: docker build -t $USER/php-release .
# Run with:
# docker run -it --rm -v/path/to/workspace:/workspace $USER/php-release

FROM ubuntu:xenial
MAINTAINER Sara Golemon <pollita@php.net>
RUN echo "mysql-server mysql-server/root_password password \"''\"" | debconf-set-selections && \
    echo "mysql-server mysql-server/root_password_again password \"''\"" | debconf-set-selections
RUN apt-get update && apt-get update --fix-missing && \
    apt-get install --yes locales language-pack-de re2c ccache mysql-server libaspell-dev \
        libbz2-dev libcurl4-gnutls-dev libenchant-dev libfreetype6-dev libgmp-dev libicu-dev \
        libjpeg-dev libkrb5-dev libonig-dev libpng-dev libpq-dev libpspell-dev libsasl2-dev \
	libsqlite3-dev libsodium-dev libtidy-dev libwebp-dev libxml2-dev libxpm-dev wget \
	libxslt1-dev libzip-dev build-essential git autoconf bison libffi-dev libreadline-dev

# Prepare a build of re2c 1.0.3 since Xenial only delivers 0.16
RUN (cd /usr/src && git clone -b 1.0.3 https://github.com/skvadrik/re2c.git re2c-1.0.3 && \
     cd re2c-1.0.3/re2c && ./autogen.sh && ./configure --prefix=/usr && make -j $(nproc))

VOLUME ["/workspace"]

COPY ./build.sh /build.sh
COPY ./manifest.sh /manifest.sh
COPY ./sign.sh /sign.sh
CMD ["/build.sh"]
