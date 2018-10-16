docker-magento
===========

This is a 'docker-compose' base configuration for Magento 1 and Magento 2. It's based upon stock PHP-FPM, Percona (MySQL) and Nginx image. It provide PHPMyAdmin and Mailcatcher as conveniance. It's recommended to use Linux to get the best performance, but you can use it in Windows perfectly.

Why use this instead of using (insert the name of your prefered Magento docker image here)

Most Magento Docker image are monolytic or at most using an external MySQL server. This may be great if you don't need to tailor the configuration often or like to rebuild image, but I prefer to be able to tweak things easily while at the same time rely on the thinest images possible. As such, it's quite easy to switch images version, add Varnish or Pound support or add a Solar server, without having to customize a Dockerfile. Docker-compose is a simpler, more elegant solution.

Features

* Latest Nginx
* Latest MariaDB (MySQL compatible)
* PHP-FPM 7.1.* with the following extensions and programs:
* Opcache
* XDebug
* gd (with freetype and jpeg support)
* iconv
* mcrypt
* curl
* dom
* hash
* pdo
* pdo_mysql
* simplexml
* soap
* sudo
* git
* cron
* wget
* libfreetype6-dev
* libjpeg62-turbo-dev
* libmcrypt-dev
* libpng-dev
* libxml2-dev
* libcurl4-openssl-dev
* libxslt-dev
* libicu-dev
* nano
* vim
* gnupg
* nodejs
* grunt-cli
* composer
* PHPMyAdmin: PHPMyAdmin is configured to allow remote connection. Use the database credentials in the following section to log onto the db server.
* MailCatcher: Mailcatcher is a fake SMTP service which catch all mail going through and allow you to read them in a web interface. Pretty usefull to debug mail template and suchs.

Services structure
----
Docker-compose use service name as hostname. You will need those while configuring
* db: MySql server (listening on port 3306)
* fpm: PHP-FPM listening on port 9000. If you need to execute PHP commands (like running n98-magerun), do it there.
* mailcatcher: (accessible on port 1080 with your web brower) 
* phpmyadmin: (accessible on port 8080 with your web brower)
* nginx: listening on http (80) only (TODO: Add SSL support)

 

Database configuration
----
The MySQL database configuration are passed to the MySQL instance as environment variables set inside the docker-compose.yml file. They are used to initialize the MySQL instance on the first run. Feel free to adjust them as you need. By default the root password, the regular user name, it's 'magento'.

 

Folder structure
----
* www : Put your public Magento folder there. If you want your Magento site to be able to write to the folder, you'll have to ensure the group 33 is write-enabled (www-data on debian, http on arch) on the folder. New files will be created with the www-data user on the PHP-FPM machine.
* db/init : Any scripts (SQL or sh) placed there will be ran on the first machine build. Usefull for importing a database
* db/data : This is where the MySQL database are stored. You can copy your MySQL database straight there too (it might require some tweaks though, have a read at the MySQL docker image documentation).



Configuration customization
----
* Nginx default site configuration is exposed in 'conf/site.conf'. The configuration is straightfowared, with basic rewrites and no security at all, if you want to add new hosts, do it in 'conf/hosts/' and reload the nginx service, remember to add to your 'hosts' file like '127.0.0.1 magento2.devel.com'.
* PHP configuration can be tailored by editing the 'conf/customized.ini'.
* FPM pool configuration is not exposed (no need for now).

 

Instructions to use it
----
Install with the command:
```
sudo docker-compose up -d
```

To see docker containers running:
```
sudo docker ps -a
```

Enter in a bash of a container:
```
sudo docker exec -it name bash
```

Restart a container:
```
sudo docker restart name
```

Delete container:
```
sudo docker rm name
```

Show docker images:
```
sudo docker images
```

Delete image:
```
sudo docker rmi id
```

To stop all containers:
```
sudo docker stop $(sudo docker ps -a -q)
```

Permissions
----
To set correct permissions if we copy files (or complete Magento installation folder) to www, execute from the fpm container:
chown -R www-data:www-data magento2
chmod -R 777 magento2
chmod u+x magento2/bin/magento

To avoid permissions problems when copy new files, do this:
HTTPDUSER=`ps axo user,comm | grep -E '[a]pache|[h]ttpd|[_]www|[w]ww-data|[n]ginx' | grep -v root | head -1 | cut -d\ -f1`
sudo setfacl -R -m u:"$HTTPDUSER":rwX -m u:`whoami`:rwX magento2
sudo setfacl -dR -m u:"$HTTPDUSER":rwX -m u:`whoami`:rwX magento2

 

Installing Magento 2
----
Enter in '/setup' of your Magento 2 files and to connect to the database use:
Host: db
Username: root
Password: magento

 

PHP Debugging
----
By default the remote port is set to 9009 and the remote handler to dbgp. The connect_back option is enable, so ensure your IDE is allowing it.

 

Adding further features
----
More PHP extensions can be added by customizing the dockerfile inside the FPM folder. Simply rebuild the FPM image after by running docker-compose up --build.
If it fail, stop the fpm container, remove it, remove the image and execute again 'sudo docker-compose up -d'.
