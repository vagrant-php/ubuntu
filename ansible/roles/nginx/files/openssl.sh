#!/bin/bash

# ./openssl.sh HOSTNAME

EXPORT_CERT_DIR=/vagrant/vagrant-php/certs
INNER_CERT_DIR=/usr/local/share/ca-certificates/self-signed
NGINX_DIR=/etc/nginx

if [[ ! $# -eq 1 ]]
then
  echo
  echo "This script needs 1 command-line argument!"
  exit 1
fi

if [[ ! -d ${INNER_CERT_DIR} ]]
then
    mkdir -p ${INNER_CERT_DIR};
fi

if [[ ! -d ${EXPORT_CERT_DIR} ]]
then
    mkdir -p ${EXPORT_CERT_DIR};
fi

if [[ ! -f ${EXPORT_CERT_DIR}/$1.crt ]];
then
    openssl req -nodes -x509 -newkey rsa:2048 -sha256 -keyout /etc/nginx/$1.key -reqexts SAN -extensions SAN -out /etc/nginx/$1.crt -days 825 -subj "/C=CH/ST=Zurich/L=Zurich/CN=$1" -config <(cat /etc/ssl/openssl.cnf; printf "[SAN]\nsubjectAltName=DNS:$1")
    cp -f /etc/nginx/$1.crt ${EXPORT_CERT_DIR}/.
    cp -f /etc/nginx/$1.crt ${INNER_CERT_DIR}/.
    cp -f /etc/nginx/$1.crt ${NGINX_DIR}/.
fi

update-ca-certificates
exit 0