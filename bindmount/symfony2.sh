echo "Executing bindmount for $1"
mkdir -p $2/cache/
mkdir -p $2/logs/
chown -Rf vagrant:vagrant $2/cache/
chown -Rf vagrant:vagrant $2/logs/
mkdir -p $3/app/cache/
mkdir -p $3/app/logs/
echo "mount -o bind $2/cache/ $3/app/cache/"
mount -o bind $2/cache/ $3/app/cache/
echo "mount -o bind $2/logs/ $3/app/logs/"
mount -o bind $2/logs/ $3/app/logs/
echo "... done!"
