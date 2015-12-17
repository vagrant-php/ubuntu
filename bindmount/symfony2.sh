echo "Executing bindmount for $1 ..."
mkdir -p /tmp/$1/cache/
mkdir -p /tmp/$1/logs/
chown -Rf vagrant:vagrant /tmp/$1/cache/
chown -Rf vagrant:vagrant /tmp/$1/logs/
mkdir -p /vagrant/app/cache/
mkdir -p /vagrant/app/logs/
mount -o bind /tmp/$1/cache/ /vagrant/app/cache/
mount -o bind /tmp/$1/logs/ /vagrant/app/logs/
echo "... done!"
