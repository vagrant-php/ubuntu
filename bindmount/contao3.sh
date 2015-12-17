echo "Executing bindmount for contao3 ..."
mkdir -p /tmp/cache/
mkdir -p /tmp/logs/
mkdir -p /tmp/tmp/
chown -Rf vagrant:vagrant /tmp/cache/
chown -Rf vagrant:vagrant /tmp/logs/
chown -Rf vagrant:vagrant /tmp/tmp/
mkdir -p /vagrant/system/cache/
mkdir -p /vagrant/system/logs/
mkdir -p /vagrant/system/tmp/
mount -o bind /tmp/cache/ /vagrant/system/cache/
mount -o bind /tmp/logs/ /vagrant/system/logs/
mount -o bind /tmp/tmp/ /vagrant/system/tmp/
echo "... done!"
