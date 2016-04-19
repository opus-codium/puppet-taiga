class taiga::back (
  $front_hostname,
  $front_protocol,
  $back_hostname,
  $back_protocol,
  $secret_key,
  $db_name = 'taiga',
  $db_user = 'taiga',
  $db_password,
  $user = 'taiga',
  $install_dir = '/srv/www/taiga-back',
  $public_register_enabled = true,
) {
  include taiga::back::user
  include taiga::back::dependencies
  include taiga::back::repo
  include taiga::back::env
  include taiga::back::config
  include taiga::back::database
  include taiga::back::migrations

  Class['taiga::back::user'] ->
  Class['taiga::back::dependencies'] ->
  Class['taiga::back::repo'] ->
  Class['taiga::back::env'] ->
  Class['taiga::back::config'] ->
  Class['taiga::back::database'] ~>
  Class['taiga::back::migrations']
}
