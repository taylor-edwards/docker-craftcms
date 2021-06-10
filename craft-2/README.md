## Getting started

Docker scripts for managing [Craft CMS](https://craftcms.com) 2.x installations with [MySQL 5.6](https://www.mysql.com/) and [certbot](https://certbot.eff.org/).

### Create a new Craft 2 site

1. Install Craft with `mkdir www && curl -s https://craftcms.com/latest-v2.tar.gz | tar -xz -C ./www`
    - Or manually download https://craftcms.com/latest-v2.zip and unzip into `./www`
    - You should have `./www/craft` and `./www/public` directories
2. Create and edit `./.env` based on the example below. Edit `./www/craft/config/db.php` with your MySQL user and password. Use `mysql` for the server address instead of an IP.
3. Make the Apache user owner of `./www`: `chown -R www-data:www-data www`
4. Start everything with `docker-compose up`
5. Run the [Craft installer](http://localhost/index.php?p=admin/install)
5. Access the site at [localhost](http://localhost)

### Import an existing Craft 2 site

1. Copy the Craft source directory into `./www/craft` and the public directory into `./www/public`
2. Create and edit `./.env` based on the example below. Edit `./www/craft/config/db.php` with your MySQL user and password. Use `mysql` for the server address instead of an IP.
3. Make the Apache user owner of `./www`: `chown -R www-data:www-data www`
4. Restore a MySQL backup by placing the `.sql` dump file in `./db-entry`
5. Start everything with `docker-compose up`
6. Access the site at [localhost](http://localhost)

### Environment files

Use a `.env` file to set up MySQL. Use the same values in `./www/craft/config/db.php` to ensure Craft can access the database.

```sh
# ./.env file example
# Configure MySQL
MYSQL_DATABASE=
MYSQL_USER=
MYSQL_PASSWORD=
MYSQL_ROOT_PASSWORD=
```

## Releases and SSL/TLS

You can manage hostnames by [configuring virtual hosts with Apache](https://httpd.apache.org/docs/2.4/vhosts/examples.html). Do **not** configure SSL by manually adding listeners on port 443 -- `certbot` will do so automatically.

Generate SSL/TLS certificates by running `certbot --apache` within the running container. If you're SSH'd into the host, you can use `docker exec -it $CONTAINER_ID certbot --apache` where `$CONTAINER_ID` can be found through `docker ps`.

## Help

Q. **Why is MySQL pinned to version 5.6?**

A. Older versions of Craft require the outdated behavior of `GROUP BY` which was changed in MySQL 5.7. If you have a workaround in place already, you can try using newer versions of MySQL.
