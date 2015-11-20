#!/bin/bash

if [ ! -d "/usr/local/lib/drush" ]; then
    git clone https://github.com/drush-ops/drush.git /usr/local/lib/drush
    ln -s /usr/local/lib/drush/drush /usr/local/bin/drush
    chmod +x /usr/local/lib/drush/drush
fi

cd /usr/local/lib/drush

git checkout 8.x
git pull origin 8.x
git checkout `git describe --abbrev=0 --tags`
composer.phar install
