FROM ubuntu:xenial
MAINTAINER Swire Chen <idoop@msn.cn>

ENV RANZHI_VER=5.0

ARG RANZHI_URL=http://dl.cnezsoft.com/ranzhi/${RANZHI_VER}/ranzhi.${RANZHI_VER}.stable.zbox_64.tar.gz

COPY docker-entrypoint /usr/local/bin/docker-entrypoint

RUN apt-get update \
    && apt-get install -y wget php-ldap --no-install-recommends \
    && rm -r /var/lib/apt/lists/* \
    && wget ${RANZHI_URL} -O zbox.tar.gz && mv zbox.tar.gz /tmp \
    && chmod +x           /usr/local/bin/docker-entrypoint

HEALTHCHECK --start-period=20s --interval=45s --timeout=3s CMD wget http://localhost/ -O /dev/null || exit 1

EXPOSE 80 3306

ENTRYPOINT ["docker-entrypoint"]
