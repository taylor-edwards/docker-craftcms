## Getting started

This repo contains docker configuration for running [CraftCMS](https://craftcms.com/) 3.x
with a Postgres database and Let's Encrypt for SSL/TLS encryption.

First time set up:

- Create an `.env` file from the template below and provide info for the Postgres configuration
- Build images and start containers with `docker-compose up`
- For local development:
    - Access the site at [localhost](http://localhost) or add `127.0.0.1 craft.dev` to `/etc/hosts` to access it at [craft.dev](http://craft.dev)
    - Run the [CraftCMS installer](http://localhost/index.php?p=admin/install) after first start up
- For production releases:
    - Set the `ServerName` in `vhost.conf` to your fully-qualified domain name. Add VirtualHost blocks and configure as needed for any subdomains or other configuration your site needs
    - Access the site at your fully-qualified domain (FQDN), e.g. _example.com_
    - Run the CraftCMS installer http://___example.com___/index.php?p=admin/install after first start up (replace ___example.com___ with your FQDN)
    - Enable SSL interactively by running `docker exec -it $CONTAINER_ID certbot --apache` after first start up


The minimum `.env` file must include:
```sh
# .env file example
# Configure Craft
DB_DRIVER=pgsql
DB_SERVER=postgres
DB_PORT=5432
DB_DATABASE=
DB_USER=
DB_PASSWORD=

# Configure Postgres
POSTGRES_USER=
POSTGRES_PASSWORD=
POSTGRES_DB=
```

Managing the service locally:
```sh
# Start:
docker-compose up

# Enable SSL (production sites only)
docker exec -it $CONTAINER_ID certbot --apache

# Stop:
docker-compose stop
```

The first time you access the site you'll have to run through CraftCMS's
install process. You can reach the page at [http://localhost/index.php?p=admin/install](http://localhost/index.php?p=admin/install).

## Help

You can manually verify docker volumes by attaching them to a temporary container:
```sh
docker run -it -v "craft_www:/var/www" debian sh
# in container:
ls -la /var/www
```

Inspect running containers by ID:
```sh
# find the container's ID:
docker ps
# run shell within that container:
docker exec -it $CONTAINER_ID sh
```
