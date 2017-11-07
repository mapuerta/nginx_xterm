#!/bin/bash

/etc/init.d/shellinabox start

echo "SECRET_TOKEN "${SECRET_TOKEN}
exec nginx -g "daemon off;" -c /etc/nginx/nginx.conf
