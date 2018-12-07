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

### Add to project

```bash
cd /path/to/my/project
git submodule add -b 18.04 https://github.com/vagrant-php/ubuntu.git vagrant-php
```

### Intialize the submodule

```bash
cd /path/to/my/project
git submodule update --init -- vagrant-php
```

### Update the submodule

```bash
cd /path/to/my/project
git submodule update --remote -- vagrant-php
```

## Configuration

### vagrant.yml (within your project dir)

```yml
---
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

## Run

```bash
cd /path/to/my/project
cd vagrant-php
vagrant up
vagrant ssh
```
