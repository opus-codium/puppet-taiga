class taiga (
  $hostname,
  $back_secret_key,
  $back_db_password,
  $protocol = 'https',
  $default_language = 'en',
  $back_directory = '/srv/www/taiga-back',
  $front_directory = '/srv/www/taiga-front',
  $back_user = 'taiga',
) {
  class { 'taiga::front':
    back_hostname    => $hostname,
    back_protocol    => $protocol,
    default_language => $default_language,
    install_dir      => $front_directory,
  }
  class { 'taiga::back':
    front_hostname => $hostname,
    front_protocol => $protocol,
    back_hostname  => $back_hostname,
    back_protocol  => $protocol,
    secret_key     => $back_secret_key,
    db_password    => $back_db_password,
    install_dir    => $back_directory,
    user           => $back_user,
  }

  class { 'taiga::vhost':
    protocol        => $protocol,
    hostname        => $hostname,
    back_directory  => $back_directory,
    front_directory => $front_directory,
    back_user       => $back_user,
  }
}
