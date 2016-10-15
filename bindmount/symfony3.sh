echo "Executing bindmount for $1"
mkdir -p $2/
chown -Rf vagrant:vagrant $2/
mkdir -p $3/var/
echo "mount -o bind $2 $3/var/"
mount -o bind $2 $3/var/
echo "... done!"
