#!/bin/bash

if [[ $# -eq 0 ]]; then
    echo "$(tput setaf 1) Parameters required. Use like:$(tput setaf 7) ./generate_vh [ServerName] [DocumentRoot] [ReloadApache]"
    exit 0
fi

echo "<VirtualHost *:80>
	            AddDefaultCharset utf-8
	            ServerName $1
	            ServerAlias www.$1
	            DocumentRoot $2
	            
	            <Directory $2 >
	             AllowOverride All
	             Order allow,deny
	             allow from all

	            <IfModule mod_rewrite.c>
	              Options -MultiViews
	              Options -Indexes
	              RewriteEngine On
	              RewriteCond %{REQUEST_FILENAME} !-f
	              RewriteRule ^ index.php [L]
	            </IfModule>

	            </Directory>

	            ErrorLog /var/log/apache2/$1-error_log
	            TransferLog /var/log/apache2/$1-access_log
</VirtualHost>" > /etc/apache2/sites-available/$1.conf

if [ -e /etc/apache2/sites-available/$1.conf ]; then
    echo "$(tput setaf 2)File generated"
else
    echo "$(tput setaf 1)Error : File not generated.."
fi

a2ensite $1.conf

if [ $3 = "true" ]; then
	/etc/init.d/apache2 restart
else
	echo "$(tput setaf 4) Apache not restarted"
fi