FROM ubuntu:14.04

RUN apt-get update && \
    apt-get install -y --no-install-recommends git nginx-extras nodejs npm && \
    cd /opt && git clone https://github.com/xtermjs/xterm.js.git && cd xterm && npm install && \
    mkdir /etc/nginx/http.conf.d && \
    sed 's%http {%include /etc/nginx/http.conf.d/*.conf;\n\nhttp {%' -i /etc/nginx/nginx.conf

COPY ./docker/env.conf /etc/nginx/http.conf.d
COPY ./docker/default /etc/nginx/sites-available/default
COPY ./docker/run.sh /etc/nginx
RUN chmod +x /etc/nginx/run.sh

ENTRYPOINT ["/etc/nginx/run.sh"]
