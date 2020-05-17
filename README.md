# vagrant-php/ubuntu

Based on: Ubuntu 20.04

## Features

 * blackfire
 * clamav
 * elasticsearch (7)
 * kafka (2.5)
 * mariadb (10.3-original, 10.3)
 * memcached
 * mongodb (4.2)
 * nginx
 * nodejs (12)
 * php (7.4-original, 7.4)
 * postfix
 * postgresql (12-original, 12)
 * rabbitmq (3.8)
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

*Needed to use disksize option:*
```bash
vagrant plugin install vagrant-disksize
```

### Project

#### Add vagrant-php to your project

*needs to be done once*

```bash
cd /path/to/my/project
git submodule add -b 20.04 https://github.com/vagrant-php/ubuntu.git vagrant-php
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
hostname: &hostname projectname.development
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

# SSL
```
There are 2 possibilities:
 * Generate SSL cert with 'mkcert' and add it to vagrant machine
 * Let the vagrant machine generate your certificates and import them to your local environment
```

## SSL - Vagrant machine generated certificates:

After provisioning all vhost certificates are generated in vagrant-php/certs
##### MacOS
```
* Open your key-chain application and import all certificates in vagrant-php/certs
* set all certificates to trusted
* enjoy ssl on your local dev environment
```
##### Linux

###### Add certificate
```
$ sudo apt-get install libnss3-tools
* for each cert file run:
  $ certutil -d sql:$HOME/.pki/nssdb -A -t "P,," -n CERT_FILE -i CERT_FILE
* enjoy ssl on your local dev environment
```
###### List trusted certificates
```
$ certutil -d sql:$HOME/.pki/nssdb -L
```
###### Remove trusted certificates
```
$ certutil -D -d sql:$HOME/.pki/nssdb -n -.lee.dev
```

## SSL - local generated certificates with mkcert:

Before provisioning add your `.crt` and `.key` files to `vagrant-php/certs-import`

e.g. `domain.tld.crt` and `domain.tld.key` - notation matters!

* generate your files to `vagrant-php/certs-import` with:

    `mkcert --cert-file=HOSTNAME.crt --key-file=HOSTNAME.key HOSTNAME`
* run vagrant provision:
* Enjoy SSH

[1]: https://www.virtualbox.org/wiki/Downloads
[2]: https://www.virtualbox.org/wiki/Linux_Downloads
[3]: https://www.vagrantup.com/downloads.html
[4]: vagrant-default.yml
