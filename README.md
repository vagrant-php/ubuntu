# vagrant-php/ubuntu

## Features

 * ubuntu 16.04
 * nginx 1.12.1
 * php 7.1 (7.2, 7.0. 7.0-original)

## Switchable features

 * elasticsearch 5 (6, 2)
 * freetds 0.91
 * mariadb 10.2 (10.1, 10.0, 10.0-original)
 * memcached 1.4
 * mongodb 3.4
 * nodejs 8 (7, 6, 5, 4, 4-original)
 * postfix 3.1
 * postgresql 9.6 (9.5, 9.5-original)
 * redis 3.2

## Installation

 * [installationguide][1]

### vagrant-php

#### register

**important**: call this only onces per project (initial setup).

```{.sh}
cd /path/to/my/project
git submodule add -b 16.04 https://github.com/vagrant-php/ubuntu.git vagrant-php
```

#### install

after checked out a prepared project or update to the version registred within the project.

```{.sh}
cd /path/to/my/project
git submodule update --init -- vagrant-php
```

#### update

get the newest version of the vagrant-php submodule.

```{.sh}
cd /path/to/my/project
git submodule update --remote -- vagrant-php
```

## Configuration

### vagrant.yml (within your project dir)

```{.yml}
---
hostname: projectname.dev
```

for advanced configuration see the [default configuration][2]

#### supported application

 * bolt2
 * bolt3
 * contao3
 * contao4
 * drupal7
 * drupal8
 * lavarel5
 * magento1
 * shopware
 * slim3
 * symfony1
 * symfony2
 * symfony3
 * symfony-flex # can be used for symfony 3.4 and symfony 4+ if created with symfony flex
 * wordpress4

#### supported sharetype

 * native
 * nfs
 * nfs-bindfs
 * sshfs

#### supported php versions

If you d'like to change the php version, you need to run `vagrant destroy and vagrant up`.

 * 7.0-original
 * 7.0
 * 7.1
 * 7.2

### .vagrant-default-user.yml (within your home directory)

This yaml is for global user overrides.

### vagrant-user.yml (within your project dir)

This yaml is for user overrides, *do not* commit this file within your project.

## Run

The vagrant setup is in a subdir, which means you need to go there, and call all vagrant commands from there.

```{.sh}
cd /path/to/my/project
cd vagrant-php
vagrant up
vagrant halt
vagrant suspend
vagrant resume
vagrant provision
vagrant ssh
```

## Thanks

 * [VMware][3] for the large discount on the [vmware workstation][4] license for testing this setup.
 * [hashicorp][5] for the large discount on the [vagrant-vmware-workstation][6] license for testing this setup.

[1]: https://github.com/vagrant-php/doc
[2]: vagrant-default.yml
[3]: https://www.vmware.com
[4]: https://www.vmware.com/products/workstation/features.html
[5]: https://hashicorp.com
[6]: https://www.vagrantup.com/vmware#buy-now
