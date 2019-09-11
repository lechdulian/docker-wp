# WPCOM VIP Go development for Docker

#### Based on: [chriszarate/docker-wordpress-vip-go](https://github.com/chriszarate/docker-wordpress-vip-go).

This repo provides a Docker-based environment for WordPress development. 
It provides WordPress, MariaDB, and WP-CLI. 

## Set up

1. Clone [this or fork this repo](https://github.com/szymonmichalik/nginx-proxy) and follow instructions. It is required to build an external network for proxy, so you can simultaneously run multiple projects on your local environment

2. Copy `sample.env` to `.env` and provide your project title, domain name (same as in step 1), database port (unique for every instance of this repo), and GitHub repo, which contains your VIP Go ready project.

3. Run `./bin/setup.sh`.

4. Run `docker-compose up -d`.

## Install WordPress

```sh
docker-compose run --rm wp-cli install-wp
```

Log in to `http://project.local/wp-admin/` with `admin@example.com` / `admin`.

## WP-CLI

You will probably want to create a shell alias for this:

```sh
docker-compose run --rm wp-cli wp [command]
```

## Troubleshooting

If your stack is not responding, the most likely cause is that a container has
stopped or failed to start. Check to see if all of the containers are "Up":

```
docker-compose ps
```

If not, inspect the logs for that container, e.g.:

```
docker-compose logs wordpress
```

Running `./bin/helpers/update_projects.sh` again can also help resolve problems.

[image]: https://hub.docker.com/r/chriszarate/wordpress/
