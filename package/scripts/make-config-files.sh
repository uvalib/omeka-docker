#!/usr/bin/env bash

# rendering mechanism
render_template() {
  eval "echo \"$(cat ${1})\""
}

# generate the .htaccess file from the template
render_template /omeka/config/.htaccess.template > /var/www/html/.htaccess
chown www-data:www-data /var/www/html/.htaccess

# generate the database settings file from the template
render_template /omeka/config/db.ini.template > /var/www/html/db.ini
chown www-data:www-data /var/www/html/db.ini

# generate the config file from the template
render_template /omeka/config/config.ini.template > /var/www/html/application/config/config.ini
chown www-data:www-data /var/www/html/application/config/config.ini

#
# end of file
#
