# Installation within osx

## Vagrant

[Download][1] and install the newest version of vagrant.

## Provider

You need at least one of this providers to use vagrant-php.

### Virtualbox

[Download][2] and install the newest version of virtualbox and virtualBox extension pack.

### VMWare

[Download][3] and install the newest version of vmware fusion.

Install the vagrant vmware plugin

```{.sh}
vagrant plugin install vagrant-vmware-fusion
```

You need to get a [license][4] and follow the instructions within the mail from HashiCorp.

## Passwordless Usage

Add the following to `/etc/sudoers`.

```
# vagrant-nfs
Cmnd_Alias VAGRANT_EXPORTS_ADD = /usr/bin/tee -a /etc/exports
Cmnd_Alias VAGRANT_NFSD = /sbin/nfsd restart
Cmnd_Alias VAGRANT_EXPORTS_REMOVE = /usr/bin/sed -E -e /*/ d -ibak /etc/exports

# vagrant-hostmanager
Cmnd_Alias VAGRANT_HOSTMANAGER_UPDATE = /bin/cp /Users/*/.vagrant.d/tmp/hosts.local /etc/hosts

%admin ALL=(root) NOPASSWD: VAGRANT_EXPORTS_ADD, VAGRANT_NFSD, VAGRANT_EXPORTS_REMOVE, VAGRANT_HOSTMANAGER_UPDATE
```

[1]: https://www.vagrantup.com/downloads.html
[2]: https://www.virtualbox.org/wiki/Downloads
[3]: http://www.vmware.com/products/fusion
[4]: http://www.vagrantup.com/vmware
