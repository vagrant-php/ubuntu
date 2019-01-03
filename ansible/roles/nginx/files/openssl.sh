#!/bin/bash

# Call this script with at least 1 parameters, for example
# ./openssl.sh HOSTNAME [SUBHOSTNAME]

MIN_PARAMS=1
IMPORT_CERT_DIR=/usr/local/share/ca-certificates/self-signed
EXPORT_CERT_DIR=/vagrant/vagrant-php/certs

if [[ $# -lt "$MIN_PARAMS" ]]
then
  echo
  echo "This script needs at least $MIN_PARAMS command-line arguments!"
  exit 0
fi

if [[ ! -d "$IMPORT_CERT_DIR" ]]
then
  mkdir -p ${IMPORT_CERT_DIR};
fi

if [[ ! -d "$EXPORT_CERT_DIR" ]]
then
  mkdir -p ${EXPORT_CERT_DIR};
fi

if [[ $# -eq 1 ]]
then
  echo
  openssl req -nodes -x509 -newkey rsa:2048 -keyout /etc/nginx/$1.key -reqexts SAN -extensions SAN -out /etc/nginx/$1.crt -days 3650 -subj "/C=CH/ST=Zurich/L=Zurich/CN=$1" -config <(cat /etc/ssl/openssl.cnf; printf "[SAN]\nsubjectAltName=DNS:$1")
  cp -f /etc/nginx/$1.crt ${EXPORT_CERT_DIR}/.
  cp -f /etc/nginx/$1.crt ${IMPORT_CERT_DIR}/.
  update-ca-certificates
  exit 0
fi
