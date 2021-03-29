#! /bin/bash

echo -e "Supervisord starting."
/usr/bin/supervisord -c /etc/supervisord.conf

echo -e "Sleeping for 5 seconds while MariaDB starts."
sleep 5

echo -e "Creating the laravel database."
mysql -u root -e "CREATE DATABASE laravel;"

echo -e "Sleeping for another 5 seconds."
sleep 5

echo -e "Modifying the default DB_HOST in .env."
sed -i 's/DB_HOST=127.0.0.1/DB_HOST=localhost/g' /var/www/html/.env

echo -e "Running Laravel Buildprint build."
php /var/www/html/artisan blueprint:build

echo -e "Running artisan migrate."
php /var/www/html/artisan migrate

echo -e "Running seeders."
php /var/www/html/artisan db:seed --class=PostSeeder

echo -e "Starting server."
php /var/www/html/artisan serve --host=0.0.0.0 --port=8080