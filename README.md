# vagrant-php/ubuntu

Based on: Ubuntu 18.04

## Features

 * blackfire
 * clamav
 * elasticsearch (6)
 * kafka (2.1.0)
 * mariadb (10.1-original, 10.1, 10.2, 10.3)
 * memcached
 * mongodb (4)
 * nginx
 * php (7.2-original, 7.2, 7.3)
 * postfix
 * postgresql (10-original, 10, 11)
 * redis

## Installation

### Virtualbox

* MacOSX and Windows: [Download][1] and install the newest version of virtualbox.
* Linux: [Download][2] and install the newest version of virtualbox or add a package mirror for your distribution.

### Vagrant

[Download][3] and install the newest version of vagrant.

#### Install plugins

### Vagrant plugins

```bash
vagrant plugin install vagrant-hostmanager
vagrant plugin install vagrant-vbguest
```

### Project

#### Add vagrant-php to your project

*needs to be done once*

```bash
cd /path/to/my/project
git submodule add -b 18.04 https://github.com/vagrant-php/ubuntu.git vagrant-php
```

#### Intialize the submodule

*needs to be done after clone the project*

```bash
cd /path/to/my/project
git submodule update --init -- vagrant-php
```

### Update the submodule

*needs to be done, when you want to upgrade vagrant-php in your project*

```bash
cd /path/to/my/project
git submodule update --remote -- vagrant-php
```

## Configuration

### .vagrant-default-user.yml

*Add generic user specific settings, for example git email which are relevant for all projects using vagrant-php. Overrides the settings of [vagrant-default.yml][4].*

```bash
cd ~
(code|nano|vi) .vagrant-default-user.yml
```

```yml
git:
    config:
        user:
            email: john.doe@gmail.com
            name: "'John Doe'"
```

### vagrant.yml

*Add project specific settings, for example the hostname. Overrides the settings of [vagrant-default.yml][4] and ~/.vagrant-default-user.yml.*

```bash
cd /path/to/my/project
(code|nano|vi) vagrant.yml
```

```yml
hostname: projectname.development
network:
    ip: 10.11.12.13
role:
    nginx: true
nginx:
    server:
        -
            root: /vagrant
            server_name: *hostname
            template: default
```

### vagrant-user.yml

*Add user and project specific settings. Overrides the settings of [vagrant-default.yml][4], ~/.vagrant-default-user.yml and vagrant.yml. Add this file to .gitignore.**

```bash
cd /path/to/my/project
(code|nano|vi) vagrant-user.yml
```

```yml
memory: 2048
```

## Run

```bash
cd /path/to/my/project
cd vagrant-php
vagrant up
vagrant ssh
```

[1]: https://www.virtualbox.org/wiki/Downloads
[2]: https://www.virtualbox.org/wiki/Linux_Downloads
[3]: https://www.vagrantup.com/downloads.html
[4]: vagrant-default.yml
