## Getting started

This repo contains docker configuration for running [CraftCMS](https://craftcms.com/) 3.x
with a Postgres database and Let's Encrypt for SSL/TLS encryption.

First time set up:

- Create an `.env` file from the template below and provide info for the Postgres configuration
- Build images and start containers with `docker-compose up`
- For local development:
    - To access the site add `127.0.0.1 craft.dev` to `/etc/hosts` then visit [craft.dev](http://craft.dev)
    - Run the [CraftCMS installer](http://craft.dev/index.php?p=admin/install) after first start up
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
DB_DATABASE=craft_db
DB_USER=
DB_PASSWORD=

# Configure Postgres
POSTGRES_DB=craft_db
POSTGRES_USER=
POSTGRES_PASSWORD=
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

## Help

You can manually verify docker volumes by attaching them to a temporary container:
```sh
# verify volume name exists:
docker volume list
# start a debian container and run shell in it with the volume attached:
docker run -it -v "docker-craftcms_www:/www" debian sh
# inspect from within the container:
ls -la /var/www
```

Inspect running containers by ID:
```sh
# find the container's ID:
docker ps
# run shell within that container:
docker exec -it $CONTAINER_ID sh
```
