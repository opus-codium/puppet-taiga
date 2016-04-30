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
  $ldap_enable = false,
  $ldap_server = undef,
  $ldap_port = 389,
  $ldap_bind_dn = undef,
  $ldap_bind_password = undef,
  $ldap_search_base = 'ou=people,dc=example,dc=com',
  $ldap_search_property = 'uid',
  $ldap_search_suffix = undef,
  $ldap_email_property = 'mail',
  $ldap_full_name_property = 'cn',
  $email_use_tls = false,
  $email_host = 'localhost',
  $email_port = 25,
  $email_user = undef,
  $email_password = undef,
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

  Class['taiga::back::repo'] ~>
  Class['taiga::back::migrations']

  if $ldap_enable {
    include taiga::back::ldap

    Class['taiga::back::env'] ->
    Class['taiga::back::ldap']
  }

  Class['taiga::back::config'] ~>
  Service['httpd']
}
