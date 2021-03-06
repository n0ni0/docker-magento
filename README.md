docker-magento
===========

This docker-compose create a lamp environment to work with Magento and ready to develop with the feature to have all your proyects reusing the same containers.
You don´t need to create new containers when start a new proyect and save space in your disk without repeated images with minimal changes.

Includes the following:

* Apache
* Mysql 5.6
* PHP-FPM with all the magento 1 and magento 2 required extensions
* sudo
* curl
* xdebug
* nano
* vim
* nodejs
* grunt-cli
* composer
* PHPMyAdmin
* gnupg
* [n98-magerun2](https://github.com/netz98/n98-magerun2)
* [pestle](https://github.com/astorm/pestle)
* [Mage2tv/magento-cache-clean](https://github.com/mage2tv/magento-cache-clean)
* [Oh My Zsh!](https://github.com/robbyrussell/oh-my-zsh)

Php Versions:
----
* 5.6
* 7.0
* 7.1
* 7.2

All php versions are ready to use and uploaded to docker-hub.
To change the php version only need to modify the number in docker-compose.yml

```
php:
    image: n0ni0/docker-magento_php_72
```

Adding further features
----
More PHP extensions can be added by customizing the dockerfile inside the FPM folder. Simply rebuild the FPM image after by running docker-compose up --build.
If it fail, stop the fpm container, remove it, remove the image and execute again 'sudo docker-compose up -d'.

Services:
----
* db: MySql server (listening on port 3306)
* fpm: PHP-FPM listening on port 9000.
* phpmyadmin: (accessible on port 8080 with your web brower)
* apache: listening on http (80) only

Folder structure
----
* public : Put your proyect folder there.
* db/init : Any scripts (SQL or sh) placed there will be ran on the first machine build. Usefull for importing a database
* db/data : This is where the MySQL database are stored. You can copy your MySQL database straight there too (it might require some tweaks though, have a read at the MySQL docker image documentation).

Database configuration
----
The MySQL database configuration are passed to the MySQL instance as environment variables set inside the docker-compose.yml file. They are used to initialize the MySQL instance on the first run. Feel free to adjust them as you need.

Configuration customization
----
* Apache default site configuration is exposed in 'apache/hosts/default.conf'. If you want to add new hosts, do it in 'apache/hosts/' and reload the apache service, remember to add to your 'hosts' file like '127.0.0.1 proyect.devel.com'.
* PHP configuration can be tailored by editing the 'fpm/conf/custom.ini'.

Instructions to use it
----
Install with the command:
```
docker-compose up -d
```
Create a new virtualhost in apache/hosts using as basic reference default.conf

Create a new host in your computer:
```
vim /etc/hosts
```
See the name of all containers:
```
docker ps -a
```
See the name of running containers:
```
docker ps
```
Restart apache container:
```
docker restart docker-magento_apache_1
```
Enter in a bash of a container:
```
sudo docker exec -it name bash
```
Restart a container:
```
sudo docker restart name
```
To stop all containers:
```
sudo docker stop $(sudo docker ps -a -q)
```

PHP Debugging
----
By default the remote port is set to 9009 and the remote handler to dbgp. The connect_back option is enable, so ensure your IDE is allowing it.

To enable xdebug execute:
```
bin/mage2.sh xdebug enable
```

To disable xdebug execute:
```
bin/mage2.sh xdebug disable
```
