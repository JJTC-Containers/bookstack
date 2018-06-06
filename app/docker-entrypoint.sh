#!/bin/sh

echo "Hide secrets:"
unset DB_ROOT_PASS

php artisan key:generate --no-interaction --force
php artisan migrate --no-interaction --force

echo "Setting folder permissions for uploads"
chown -R www-data:www-data public/uploads storage/uploads

php artisan cache:clear
php artisan view:clear

echo "php-fpm is ready to serve"
exec php-fpm
