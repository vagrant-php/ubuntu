echo "Executing bindmount for $1 ..."
mkdir -p /tmp/$1/cache/
mkdir -p /tmp/$1/logs/
mkdir -p /tmp/$1/tmp/
chown -Rf vagrant:vagrant /tmp/$1/cache/
chown -Rf vagrant:vagrant /tmp/$1/logs/
chown -Rf vagrant:vagrant /tmp/$1/tmp/
mkdir -p /vagrant/system/cache/
mkdir -p /vagrant/system/logs/
mkdir -p /vagrant/system/tmp/
mount -o bind /tmp/$1/cache/ /vagrant/system/cache/
mount -o bind /tmp/$1/logs/ /vagrant/system/logs/
mount -o bind /tmp/$1/tmp/ /vagrant/system/tmp/
echo "... done!"
