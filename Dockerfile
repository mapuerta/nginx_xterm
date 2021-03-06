FROM vauxoo/docker-ubuntu-base:16.04

ENV PASSWORD=shellmanager
ENV SHELLUSER=shellmanager

RUN apt-get update && \
    apt-get install -y --no-install-recommends nginx-extras shellinabox && \
    mkdir /etc/nginx/http.conf.d && \
    sed 's%http {%include /etc/nginx/http.conf.d/*.conf;\n\nhttp {%' -i /etc/nginx/nginx.conf

RUN useradd -ms /bin/bash ${SHELLUSER} && echo "${SHELLUSER}:${PASSWORD}" | chpasswd

RUN adduser ${SHELLUSER} shellinabox

COPY ./docker/env.conf /etc/nginx/http.conf.d
COPY ./docker/default /etc/nginx/sites-enabled/default
COPY ./docker/shellinabox /etc/default/shellinabox
COPY ./docker/run.sh /entrypoint
RUN chmod +x /entrypoint

ENTRYPOINT ["/entrypoint"]
