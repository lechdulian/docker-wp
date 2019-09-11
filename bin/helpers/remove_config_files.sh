#!/bin/sh

# Set the variable for bash behavior
shopt -s nullglob
shopt -s dotglob

echo "Removing docker-compose.yml ..."
rm -f ./docker-compose.yml

echo "Removing install-wp.sh ..."
rm -f ./bin/install-wp.sh

echo "Removing wp-local-config.php ..."
rm -f ./bin/wp-local-config.php

echo "Done!"