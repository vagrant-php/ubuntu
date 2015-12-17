echo "Executing bindmount for symfony2 ..."
mkdir -p /tmp/symfony2/cache/
mkdir -p /tmp/symfony2/logs/
chown -Rf vagrant:vagrant /tmp/symfony2/cache/
chown -Rf vagrant:vagrant /tmp/symfony2/logs/
mkdir -p /vagrant/app/cache/
mkdir -p /vagrant/app/logs/
mount -o bind /tmp/symfony2/cache/ /vagrant/app/cache/
mount -o bind /tmp/symfony2/logs/ /vagrant/app/logs/
echo "... done!"
