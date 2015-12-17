echo "Executing bindmount for symfony3 ..."
mkdir -p /tmp/var/
chown -Rf vagrant:vagrant /tmp/var/
mkdir -p /vagrant/var/
mount -o bind /tmp/var/ /vagrant/var/
echo "... done!"
