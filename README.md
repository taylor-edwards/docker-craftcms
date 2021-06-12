# Docker for Craft CMS

This repo contains Docker scripts to create and manage [Craft CMS](https://craftcms.com) 2.x and 3.x web applications.

Note that Craft publishes [an official image](https://hub.docker.com/r/craftcms/nginx) for hosting CraftCMS with nginx already; however, these images vary in that they use a persistent volume for Craft's files to make deploying updates as easy as using sFTP or rsync, they self-host [certbot](https://certbot.eff.org/), and the configuration includes support for Apache HTTPD with virtual hosts.
