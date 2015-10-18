# vagrant-php/ubuntu

## Features

 * ubuntu 14.04
 * nginx 1.8
 * php (5.5, 5.6, 7.0, hhvm)

## Switchable features

 * elasticsearch 1.7
 * freetds 0.91
 * mariadb 10.0
 * memcached 1.4
 * mongodb 3.0
 * nodejs 0.12
 * postgresql 9.4
 * redis 3.0.4
 * ruby 2.1.5

## Installation

 * [linux][1]
 * [osx][2]
 * [windows][3]

### Plugin

#### Hostmanager

```{.sh}
vagrant plugin install vagrant-hostmanager
```

### vagrant-php

#### register

**important**: call this only onces per project (initial setup).

```{.sh}
cd /path/to/my/project
git submodule add -b 14.04 https://github.com/vagrant-php/ubuntu.git
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

for advanced configuration see the [default configuration][4]

#### supported application

 * contao3
 * drupal7
 * lavarel5
 * symfony2
 * wordpress4

#### supported sharetype

 * native
 * nfs
 * nfs-bindfs

#### supported php versions

If you d'like to change the php version, you need to run `vagrant destroy and vagrant up`.

 * 5.5-original
 * 5.5
 * 5.6
 * 7.0
 * hhvm

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

## Troubleshooting

 * [all platforms][6]
 * [linux][7]
 * [osx][8]
 * [windows][9]

## Thanks

 * [VMware][10] for the large discount on the [vmware workstation][11] license for testing this setup.
 * [hashicorp][12] for the large discount on the [vagrant-vmware-workstation][13] license for testing this setup.

[1]: doc/installation/linux.md
[2]: doc/installation/osx.md
[3]: doc/installation/windows.md
[4]: vagrant-default.yml
[6]: doc/troubleshooting/allplatforms.md
[7]: doc/troubleshooting/linux.md
[8]: doc/troubleshooting/osx.md
[9]: doc/troubleshooting/windows.md
[10]: https://www.vmware.com
[11]: https://www.vmware.com/products/workstation/features.html
[12]: https://hashicorp.com
[13]: https://www.vagrantup.com/vmware#buy-now
