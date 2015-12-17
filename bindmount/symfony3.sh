echo "Executing bindmount for symfony3 ..."
mkdir -p /tmp/symfony3/var/
chown -Rf vagrant:vagrant /tmp/symfony3/var/
mkdir -p /vagrant/var/
mount -o bind /tmp/symfony3/var/ /vagrant/var/
echo "... done!"
