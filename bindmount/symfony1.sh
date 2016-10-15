echo "Executing bindmount for $1"
mkdir -p $2/cache/
mkdir -p $2/log/
chown -Rf vagrant:vagrant $2/cache/
chown -Rf vagrant:vagrant $2/log/
mkdir -p $3/cache/
mkdir -p $3/log/
echo "mount -o bind $2/cache/ $3/cache/"
mount -o bind $2/cache/ $3/cache/
echo "mount -o bind $2/log/ $3/log/"
mount -o bind $2/log/ $3/log/
echo "... done!"
