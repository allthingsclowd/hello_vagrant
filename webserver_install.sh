#!/usr/bin/env bash

# Idempotency hack - if this file exists don't run the rest of the script
if [-f "/var/vagrant_web_server"]; then
    exit 0
fi

touch /var/vagrant_web_server
apt-get update
apt-get install -y nginx
service nginx start