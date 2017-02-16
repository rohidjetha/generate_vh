#!/bin/bash

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
</VirtualHost>" > ~/Desktop/$1.conf

if [ $3 = "true" ]
then
	ls;
else
	echo "Apache not restarted";
fi