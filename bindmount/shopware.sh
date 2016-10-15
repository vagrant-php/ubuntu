echo "Executing bindmount for $1"
mkdir -p $2/cache/
mkdir -p $2/logs/
chown -Rf vagrant:vagrant $2/cache/
chown -Rf vagrant:vagrant $2/logs/
mkdir -p $3/web/cache/
mkdir -p $3/var/logs/
echo "mount -o bind $2/cache/ $3/web/cache/"
mount -o bind $2/cache/ $3/web/cache/
echo "mount -o bind $2/logs/ $3/var/log/"
mount -o bind $2/logs/ $3/var/log/
echo "... done!"
