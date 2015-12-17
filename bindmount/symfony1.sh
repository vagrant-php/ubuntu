echo "Executing bindmount for symfony1 ..."
mkdir -p /tmp/cache/
mkdir -p /tmp/log/
chown -Rf vagrant:vagrant /tmp/cache/
chown -Rf vagrant:vagrant /tmp/log/
mkdir -p /vagrant/cache/
mkdir -p /vagrant/log/
mount -o bind /tmp/cache/ /vagrant/cache/
mount -o bind /tmp/log/ /vagrant/log/
echo "... done!"
