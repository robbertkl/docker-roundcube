# robbertkl/roundcube

[![](https://badge.imagelayers.io/robbertkl/roundcube:latest.svg)](https://imagelayers.io/?images=robbertkl/roundcube:latest)

Roundcube Docker container:

* Made for [robbertkl/docker-mail](https://github.com/robbertkl/docker-mail), but can be used separately
* It differs from [alunduil/roundcube](https://hub.docker.com/r/alunduil/roundcube/) in a number of ways:
    * Built from stable Roundcube releases, instead of a random master snapshot
    * Uses NGINX instead of Apache
    * No SSL support (use a separate reverse proxy container if you need SSL)
    * Hardcoded to sqlite (no need to configure a database)
    * Defines a volume for database persistence
    * Includes an additional plugin for carddav
    * Some default configuration, like enabled plugins and connection settings

## Usage

Run it like this:

```
docker run -d -p 80:80 robbertkl/roundcube
```

Or you could use a separate data container, for example:

```
docker create --name roundcube_data robbertkl/roundcube true
docker run --name roundcube -d --volumes-from roundcube_data -p 80:80 robbertkl/roundcube
```

## Environment variables

To configure Roundcube, you can use `ROUNDCUBE_` environment variables for all regular configuration option (e.g. `ROUNDCUBE_DEFAULT_HOST`, `ROUNDCUBE_SMTP_SERVER`, etc). Additionally, the password plugin file driver adds a `ROUNDCUBE_USER_FILE` variable to set the path to password file.

## Authors

* Robbert Klarenbeek, <robbertkl@renbeek.nl>

## License

This repo is published under the [MIT License](http://www.opensource.org/licenses/mit-license.php).
