echo "Executing bindmount for $1 ..."
mkdir -p /tmp/$1/cache/
mkdir -p /tmp/$1/log/
chown -Rf vagrant:vagrant /tmp/$1/cache/
chown -Rf vagrant:vagrant /tmp/$1/log/
mkdir -p /vagrant/cache/
mkdir -p /vagrant/log/
mount -o bind /tmp/$1/cache/ /vagrant/cache/
mount -o bind /tmp/$1/log/ /vagrant/log/
echo "... done!"
