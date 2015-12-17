echo "Executing bindmount for symfony2 ..."
mkdir -p /tmp/cache/
mkdir -p /tmp/logs/
chown -Rf vagrant:vagrant /tmp/cache/
chown -Rf vagrant:vagrant /tmp/logs/
mkdir -p /vagrant/app/cache/
mkdir -p /vagrant/app/logs/
mount -o bind /tmp/cache/ /vagrant/app/cache/
mount -o bind /tmp/logs/ /vagrant/app/logs/
echo "... done!"
