echo "Executing bindmount for $1"
mkdir -p $2/cache/
mkdir -p $2/logs/
mkdir -p $2/tmp/
chown -Rf vagrant:vagrant $2/cache/
chown -Rf vagrant:vagrant $2/logs/
chown -Rf vagrant:vagrant $2/tmp/
mkdir -p $3/system/cache/
mkdir -p $3/system/logs/
mkdir -p $3/system/tmp/
echo "mount -o bind $2/cache/ $3/system/cache/"
mount -o bind $2/cache/ $3/system/cache/
echo "mount -o bind $2/logs/ $3/system/logs/"
mount -o bind $2/logs/ $3/system/logs/
echo "mount -o bind $2/tmp/ $3/system/tmp/"
mount -o bind $2/tmp/ $3/system/tmp/
echo "... done!"
