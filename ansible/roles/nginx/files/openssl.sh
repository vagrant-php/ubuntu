#!/bin/bash

# ./openssl.sh HOSTNAME

EXTERN_CERT_DIR=/vagrant/vagrant-php/certs
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

if [[ ! -f ${EXTERN_CERT_DIR}/$1.crt || ! -f ${EXTERN_CERT_DIR}/$1.key ]];
then
    openssl req -nodes -x509 -newkey rsa:2048 -sha256 -keyout ${EXTERN_CERT_DIR}/$1.key -reqexts SAN -extensions SAN -out ${EXTERN_CERT_DIR}/$1.crt -days 1024 -subj "/C=CH/ST=Zurich/L=Zurich/CN=$1" -config <(cat /etc/ssl/openssl.cnf; printf "[SAN]\nsubjectAltName=DNS:$1")
fi

cp -f ${EXTERN_CERT_DIR}/$1.{key,crt} ${NGINX_DIR}/.
cp -f ${EXTERN_CERT_DIR}/$1.crt ${INNER_CERT_DIR}/.

update-ca-certificates
exit 0