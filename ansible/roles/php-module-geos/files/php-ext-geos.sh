#!/bin/bash

if [ ! -d "/usr/local/lib/php-ext-geos" ]; then
    git clone https://gitlab.com/geos/php-geos.git /usr/local/lib/php-ext-geos
fi

cd /usr/local/lib/php-ext-geos
./autogen.sh
./configure
make
make install
