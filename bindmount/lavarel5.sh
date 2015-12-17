echo "Executing bindmount for $1 ..."
mkdir -p /tmp/$1/cache/
chown -Rf vagrant:vagrant /tmp/$1/cache/
mkdir -p /vagrant/bootstrap/cache/
mount -o bind /tmp/$1/cache/ /vagrant/bootstrap/cache/
echo "... done!"
