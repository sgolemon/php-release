# Build PHP releases with ease
# Based on dshafik/php-build, but removes interactivity requirement

# Build with: docker build -t $USER/php-release .
# Run with:
# docker run -it --rm -v/path/to/workspace:/workspace $USER/php-release

FROM debian:jessie
MAINTAINER Sara Golemon <pollita@php.net>
RUN echo "mysql-server mysql-server/root_password password \"''\"" | debconf-set-selections && \
    echo "mysql-server mysql-server/root_password_again password \"''\"" | debconf-set-selections
RUN apt-get update && apt-get update --fix-missing && \
    apt-get install --yes build-essential mysql-server postgresql libgd-dev libxml2 libxslt1-dev \
    libtidy-dev libreadline6 gettext libfreetype6 git autoconf bison re2c openssl pkg-config libssl-dev \
    libbz2-dev libcurl4-openssl-dev libenchant-dev libgmp-dev libicu-dev libmcrypt-dev \
    postgresql-server-dev-all libpspell-dev libreadline-dev gnupg wget \
    && rm -rf /var/lib/apt/lists/*
RUN ln -s /usr/include/x86_64-linux-gnu/gmp.h /usr/include/gmp.h

# Prepare a build of re2c 1.0.3 since Jessie only delivers 0.13.5
RUN (cd /usr/src && git clone -b 1.0.3 git://github.com/skvadrik/re2c.git re2c-1.0.3 && \
     cd re2c-1.0.3/re2c && ./autogen.sh && ./configure --prefix=/usr && make -j $(nproc))

VOLUME ["/workspace"]

COPY ./build.sh /build.sh
COPY ./manifest.sh /manifest.sh
COPY ./sign.sh /sign.sh
CMD ["/build.sh"]
