## Getting started

Docker scripts for managing [Craft CMS](https://craftcms.com) 3.x installations with [Postgres](https://www.postgresql.org/) and [certbot](https://certbot.eff.org/).

### Create a new Craft 3 site

1. Install Craft to the `www` volume with `docker run -it --rm -v $(pwd)/www:/craft -w /craft composer:latest composer create-project craftcms/craft .`. Select "no" (default) when prompted to finish setting up.
2. Create and edit `./.env` based on the example below. Edit `./www/.env` with your Postgres user and password. Use `postgres` for the server address instead of an IP.
3. Make the Apache user owner of `./www`: `chown -R www-data:www-data www`
4. Start everything with `docker-compose up`
5. Run the [Craft installer](http://localhost/index.php?p=admin/install)
6. Access the site at [localhost](http://localhost)

### Import an existing Craft 3 site

1. Copy the entire Craft site directory into `./www`
    - You should have `./www/.env`, `./www/config`, `./www/web`, etc
2. Use the values from `./www/.env` to create and edit `./.env` based on the example below. Edit `./www/.env` to configure Postgres with `DB_DRIVER=pgsql` and `DB_SERVER=postgres`
3. Make the Apache user owner of `./www`: `chown -R www-data:www-data www`
4. Restore a Postgres backup by placing the `.sql` dump file in `./db-entry`
5. Start everything with `docker-compose up`
6. Access the site at [localhost](http://localhost)

### Environment files

Use a `.env` file to set up Postgres. Use the same values in `./www/.env` to ensure Craft can access the database.

```sh
# .env file example
# Configure Postgres
POSTGRES_DB=
POSTGRES_USER=
POSTGRES_PASSWORD=
```

```sh
# www/.env file example
# Configure Craft
DB_DRIVER=pgsql
DB_SERVER=postgres
DB_PORT=5432
DB_DATABASE= # must match ./.env POSTGRES_DB
DB_USER=     # must match ./.env POSTGRES_USER
DB_PASSWORD= # must match ./.env POSTGRES_PASSWORD
```

## Releases and SSL/TLS

You can manage hostnames by [configuring virtual hosts with Apache](https://httpd.apache.org/docs/2.4/vhosts/examples.html). Do **not** configure SSL by manually adding listeners on port 443 -- `certbot` will do so automatically.

Generate SSL/TLS certificates by running `certbot --apache` within the running container. If you're SSH'd into the host, you can use `docker exec -it $CONTAINER_ID certbot --apache` where `$CONTAINER_ID` can be found through `docker ps`.
