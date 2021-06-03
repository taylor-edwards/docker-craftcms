## Getting started

This repo contains docker configuration for running [CraftCMS](https://craftcms.com/) 3.x
with a Postgres database.

First time set up:

- Set database, user and password for Postgres in `.env`
- (optional) Create volumes to persist storage and the database
- Run the [CraftCMS installer](http://localhost/index.php?p=admin/install) after first start up

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

Starting and stopping the service:

```
# start:
docker-compose up
# stop (or use Ctrl-C):
docker-compose stop
```

The first time you access the site you'll have to run through CraftCMS's
install process. You can reach the page at [http://localhost/index.php?p=admin/install](http://localhost/index.php?p=admin/install).

## Todo

* Use persistent volume for the main site storage
* Add SSL/TLS support with Let's Encrypt
