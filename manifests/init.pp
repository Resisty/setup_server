# == Class: changeme
#
# Manages ${change} on Ubuntu servers
# Add more comments about class here.
#
# === Variables
#
# [*variable_name*]
#   Description
#
# === Examples
#
# === Authors
#
# Brian Auron <brianauron@gmail.com>
#
# === Copyright
#
# Copyright 2015 Brian Auron.
#
class setup_server(
  # variables here
) {
  include apache
  apache::vhost { 'brianauron.info':
    docroot                     => '/var/www/html',
    directories                 => [
      { path     => '/var/www/html/characters',
        order    => 'deny,allow',
        provider => 'location',
        allow    => 'from all',
      },
    ],
    priority                    => '25',
    error_documents             => [
      { 'error_code'  => '404',
        'document'    => '/img/wellmet.gif' },
    ],
    wsgi_daemon_process         => 'scrape_characters',
    wsgi_daemon_process_options =>
      { threads                 => '1',
        user                    => 'characterscraper',
        group                   => 'characterscraper',
      },
    wsgi_process_group          => 'scrape_characters',
    wsgi_script_aliases         =>
      { '/scrape_characters'   => '/var/www/html/characterscraper.wsgi' },
    custom_fragment             => 'WSGIScriptReloading On',
  }
}
