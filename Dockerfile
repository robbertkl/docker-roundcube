FROM robbertkl/php
MAINTAINER Robbert Klarenbeek <robbertkl@renbeek.nl>

# Change NGINX document root
ENV DOCUMENT_ROOT=/var/www/public_html
WORKDIR ${DOCUMENT_ROOT}/..

# Install Roundcube + plugins
RUN VERSION=`latestversion roundcube/roundcubemail` \
    && rm -rf * \
    && git clone --branch ${VERSION} --depth 1 https://github.com/roundcube/roundcubemail.git . \
    && rm -rf .git installer
RUN composer self-update --snapshot \
    && mv composer.json-dist composer.json \
    && composer config secure-http false \
    && composer require --update-no-dev \
        roundcube/plugin-installer:dev-master \
        roundcube/carddav \
    && ln -sf ../../vendor plugins/carddav/vendor \
    && composer clear-cache

# Init scripts (volume preparation)
COPY etc /etc

# Setup logging
RUN echo /var/www/logs/errors >> /etc/services.d/logs/stderr

# Configure Roundcube + plugins
COPY config.inc.php config/
COPY plugins-password-config.inc.php plugins/password/config.inc.php
COPY plugins-password-file.php plugins/password/drivers/file.php

# Install missing JS dependencies
RUN cleaninstall unzip file
RUN bin/install-jsdeps.sh

# Keep the db in a volume for persistence
VOLUME /var/www/db
