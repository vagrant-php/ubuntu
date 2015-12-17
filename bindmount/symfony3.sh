echo "Executing bindmount for $1 ..."
mkdir -p /tmp/$1/var/
chown -Rf vagrant:vagrant /tmp/$1/var/
mkdir -p /vagrant/var/
mount -o bind /tmp/$1/var/ /vagrant/var/
echo "... done!"
