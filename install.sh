#!/bin/bash

docker build -t nginx-shell .

TOKEN=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)

docker run -e SECRET_TOKEN=${TOKEN} -p 10080:80 -p 14200:4200 -it nginx-shell
