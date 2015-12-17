echo "Executing bindmount for contao3 ..."
mkdir -p /tmp/contao3/cache/
mkdir -p /tmp/contao3/logs/
mkdir -p /tmp/contao3/tmp/
chown -Rf vagrant:vagrant /tmp/contao3/cache/
chown -Rf vagrant:vagrant /tmp/contao3/logs/
chown -Rf vagrant:vagrant /tmp/contao3/tmp/
mkdir -p /vagrant/system/cache/
mkdir -p /vagrant/system/logs/
mkdir -p /vagrant/system/tmp/
mount -o bind /tmp/contao3/cache/ /vagrant/system/cache/
mount -o bind /tmp/contao3/logs/ /vagrant/system/logs/
mount -o bind /tmp/contao3/tmp/ /vagrant/system/tmp/
echo "... done!"
