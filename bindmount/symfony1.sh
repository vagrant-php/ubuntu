echo "Executing bindmount for symfony1 ..."
mkdir -p /tmp/symfony1/cache/
mkdir -p /tmp/symfony1/log/
chown -Rf vagrant:vagrant /tmp/symfony1/cache/
chown -Rf vagrant:vagrant /tmp/symfony1/log/
mkdir -p /vagrant/cache/
mkdir -p /vagrant/log/
mount -o bind /tmp/symfony1/cache/ /vagrant/cache/
mount -o bind /tmp/symfony1/log/ /vagrant/log/
echo "... done!"
