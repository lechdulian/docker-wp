#!/bin/sh

# Set the variable for bash behavior
shopt -s nullglob
shopt -s dotglob

if [ ! -z "$(docker-compose ps | sed -e '/^\-\-\-/,$!d' -e '/^\-\-\-/d')" ]; then
  echo "Please run \`docker-compose down\` before running this script. (You will need"
  echo "to reimport content after this script completes.)"
  exit 1
fi

if [ ! -f .env ]; then
  echo "Config file does not exist. Nothing to do."
  exit 1
fi

source .env

# include helpers
. bin/helpers/render_template.sh
. bin/helpers/update_projects.sh

echo "Creating directories..."
echo ""

if [ -f docker-compose.yml ]; then
  echo "Recreating \`docker-compose.yml\`..."
  rm -f ./docker-compose.yml
fi
render_template ./templates/docker-compose.yml.tmpl > ./docker-compose.yml
chmod +x ./docker-compose.yml


if [ -f ./bin/wp-local-config.php ]; then
  echo "File \"wp-local-config.php\" exists, skipping."
else
  if [ "$PROJECT_IS_MULTISITE" == "1" ] || [ "$PROJECT_IS_MULTISITE" == "true" ] ; then
    echo "Creating wp-local-config.php file for multisite..."
    render_template ./templates/wp-local-config-mu.php.tmpl > ./bin/wp-local-config.php
  else
    echo "Creating wp-local-config.php file for single WordPress site"
    render_template ./templates/wp-local-config.php.tmpl > ./bin/wp-local-config.php
  fi 
fi

if [ -f ./bin/install-wp.sh ]; then
    echo "File \"install-wp.sh\" exists, skipping."
else
  if [ "$PROJECT_IS_MULTISITE" == "1" ] || [ "$PROJECT_IS_MULTISITE" == "true" ] ; then
    render_template ./templates/install-wp-mu.sh.tmpl > ./bin/install-wp.sh
  else
    render_template ./templates/install-wp.sh.tmpl > ./bin/install-wp.sh
  fi
  chmod +x ./bin/install-wp.sh
fi

echo "Done."
echo ""

# Pull projects
echo "Updating ${PROJECT_TITLE} project..."
update_projects
echo "Done."
echo ""

# allow access to helpers
chmod +x ./bin/helpers/*.sh

# Done!
echo "Done! You are ready to run your Docker now."
echo ""
echo "To create project containers, run \`docker-compose up -d\`. If your container already exists, this will remove existing data."
echo "To start, run \`docker-compose start\`."
echo "To stop, run \`docker-compose stop\`."
echo "To prune, run \`docker system prune\`. Data will be lost."
echo ""
echo "You can continue your setup by running following commands:"
echo ""
echo "  docker-compose run --rm wp-cli install-wp    install WordPress (requires running docker)"
echo ""
echo "  HELPERS:"
echo "      ./bin/helpers/remove_config_files.sh    remove all config files created during setup.sh"
echo "      ./bin/helpers/update_projects.sh        clone or update project's git repositories"
echo ""
