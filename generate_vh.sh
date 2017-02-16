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
</VirtualHost>" > /etc/apache2/sites-available/$1.conf

if [ -a /etc/apache2/sites-available/$1.conf ]; then
    echo "File generated"
else
    echo "Error : File not generated.."
fi

if [ a2ensite $1.conf ]; then
    echo "Site enabled"
fi

if [ $3 = "true" ]; then
	/etc/init.d/apache2 restart
else
	echo "Apache not restarted"
fi