## Getting started

This repo contains docker configuration for running [CraftCMS](https://craftcms.com/) 3.x
with a Postgres database.

First time set up:

- Set database, user and password for Postgres in `.env`
- For local development:
    - Access the site at [localhost](http://localhost) or add `127.0.0.1 craft.dev` to `/etc/hosts` to access it at [craft.dev](http://craft.dev)
    - Run the [CraftCMS installer](http://localhost/index.php?p=admin/install) after first start up
- For production releases:
    - Set the `ServerName` in `vhost.conf` to your fully-qualified domain name. Add VirtualHost blocks and configure as needed for any subdomains or other functionality
    - Access the site at your fully-qualified domain (FQDN), e.g. example.com
    - Run the CraftCMS installer http://_example.com_/index.php?p=admin/install after first start up (replace `example.com` with your FQDN)
    - Enable SSL interactively by running `docker exec -it ... sh` and then `certbot --apache` within the container


The minimum `.env` file must include:

```
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

```
# Start:
docker-compose up

# Enable SSL (production sites only)
docker exec -it <pid> sh
# at the container's prompt:
certbot --apache
# Ctrl-D to exit container

# Stop:
docker-compose stop
```

The first time you access the site you'll have to run through CraftCMS's
install process. You can reach the page at [http://localhost/index.php?p=admin/install](http://localhost/index.php?p=admin/install).

## Todo

* Use persistent volume for the main site storage
