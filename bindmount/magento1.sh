echo "Executing bindmount for $1, $2, $3 ..."
mkdir -p $2/cache/
mkdir -p $2/log/
mkdir -p $2/session/
mkdir -p $2/tmp/
chown -Rf vagrant:vagrant $2/cache/
chown -Rf vagrant:vagrant $2/log/
chown -Rf vagrant:vagrant $2/session/
chown -Rf vagrant:vagrant $2/tmp/
mkdir -p $3/var/cache/
mkdir -p $3/var/log/
mkdir -p $3/var/session/
mkdir -p $3/var/tmp/
mount -o bind $2/cache/ $3/var/cache/
mount -o bind $2/log/ $3/var/log/
mount -o bind $2/session/ $3/var/session/
mount -o bind $2/tmp/ $3/var/tmp/
echo "... done!"
