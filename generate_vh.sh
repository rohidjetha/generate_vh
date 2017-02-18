#!/bin/bash

#Default parameters
domain=$1
rootDir=$2
opt=$3
sitesAvailable='/etc/apache2/sites-available/'

if [[ $# -eq 0 ]]; then
    echo "$(tput setaf 1) Parameters required. Use like:$(tput setaf 7) ./generate_vh [ServerName] [DocumentRoot] [ReloadApache]"
    exit 0
fi

echo "<VirtualHost *:80>
	            AddDefaultCharset utf-8
	            ServerName "$domain"
	            ServerAlias www."$domain"
	            DocumentRoot "$rootDir"
	            
	            <Directory "$rootDir" >
	             AllowOverride All
	             Order allow,deny
	             allow from all
	             #others guidelines here if needed..
                    </Directory>

	            ErrorLog /var/log/apache2/"$domain"-error_log
	            TransferLog /var/log/apache2/"$domain"-access_log
</VirtualHost>" > $sitesAvailable$domain.conf

if [ -e $sitesAvailable$domain.conf ]; then
    echo "$(tput setaf 2)Virtual Host Created ($domain.conf)"
else
    echo "$(tput setaf 1)Error : File not generated.."
fi

a2ensite $domain.conf

if [ $opt = "yes" ]; then
	/etc/init.d/apache2 restart
else
	echo "$(tput setaf 4) Apache not restarted"
fi
