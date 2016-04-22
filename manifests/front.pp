class taiga::front (
  $back_hostname,
  $back_protocol,
  $events = false,
  $user = 'nobody',
  $install_dir = '/srv/www/taiga-front',
  $default_language = 'en',
  $public_register_enabled = true,
  $login_form_type = undef,
) {
  include taiga::front::repo
  include taiga::front::config

  Class['taiga::front::repo'] ->
  Class['taiga::front::config']
}
