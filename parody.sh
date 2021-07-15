#! /bin/bash

SCAFFOLD="$1"

if [[ $# -eq 0 ]]; then
    echo -e "Scaffold option is empty, setting it to todo."
    SCAFFOLD="todo"
fi

if [ $SCAFFOLD == "todo" ] || [ $SCAFFOLD == "blog" ]; then
    SCAFFOLD="https://github.com/aschmelyun/parody-${SCAFFOLD}.git"
else
    SCAFFOLD="https://github.com/${SCAFFOLD}.git"
fi

echo -e "Scaffold is set to ${SCAFFOLD}."

echo -e "Supervisord starting."
/usr/bin/supervisord -c /etc/supervisord.conf

echo -e "Sleeping for 5 seconds while MariaDB starts."
sleep 5

echo -e "Creating the laravel database."
mysql -u root -e "CREATE DATABASE laravel;"

echo -e "Modifying the default DB_HOST in .env."
sed -i 's/DB_HOST=127.0.0.1/DB_HOST=localhost/g' /var/www/html/.env

echo -e "Cloning the API scaffold."
git clone $SCAFFOLD scaffold
cp -afu ./scaffold/. /var/www/html/
rm -rf ./scaffold

echo -e "Running artisan jwt:secret."
php /var/www/html/artisan jwt:secret

echo -e "Running artisan migrate."
php /var/www/html/artisan migrate

echo -e "Running seeders."
php /var/www/html/artisan db:seed

echo -e "Starting server."
php /var/www/html/artisan serve --host=0.0.0.0 --port=80
