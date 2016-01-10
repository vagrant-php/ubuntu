#!/bin/bash

if [ ! -d "/usr/local/lib/drush8" ]; then
    git clone https://github.com/drush-ops/drush.git /usr/local/lib/drush8
    chmod +x /usr/local/lib/drush8/drush
    ln -s /usr/local/lib/drush8/drush /usr/local/bin/drush8
fi

cd /usr/local/lib/drush8

git checkout 8.x
git pull origin 8.x
git checkout `git describe --abbrev=0 --tags`
composer.phar install
