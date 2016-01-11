#!/bin/bash

if [ ! -d "/usr/local/lib/drush7" ]; then
    git clone https://github.com/drush-ops/drush.git /usr/local/lib/drush7
    chmod +x /usr/local/lib/drush7/drush
    ln -s /usr/local/lib/drush7/drush /usr/local/bin/drush7
fi

cd /usr/local/lib/drush7

git checkout 7.x
git pull origin 7.x
git checkout `git describe --abbrev=0 --tags`
composer.phar install
