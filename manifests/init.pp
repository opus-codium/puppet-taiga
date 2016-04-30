class taiga (
  $hostname,
  $back_secret_key,
  $back_db_password,
  $protocol = 'https',
  $default_language = 'en',
  $back_directory = '/srv/www/taiga-back',
  $front_directory = '/srv/www/taiga-front',
  $back_user = 'taiga',
  $public_register_enabled = true,
  $ldap_server = undef,
  $ldap_port = 389,
  $ldap_bind_dn = undef,
  $ldap_bind_password = undef,
  $ldap_search_base = 'ou=people,dc=example,dc=com',
  $ldap_search_property = 'uid',
  $ldap_search_suffix = undef,
  $ldap_email_property = 'mail',
  $ldap_full_name_property = 'cn',
  $ssl_cert = undef,
  $ssl_key = undef,
  $ssl_chain = undef,
) {
  $ldap_enable = $ldap_server ? {
    undef   => false,
    default => true,
  }

  class { 'taiga::front':
    back_hostname           => $hostname,
    back_protocol           => $protocol,
    default_language        => $default_language,
    install_dir             => $front_directory,
    public_register_enabled => $public_register_enabled,
    ldap_enable             => $ldap_enable,
  }
  class { 'taiga::back':
    front_hostname          => $hostname,
    front_protocol          => $protocol,
    back_hostname           => $back_hostname,
    back_protocol           => $protocol,
    secret_key              => $back_secret_key,
    db_password             => $back_db_password,
    install_dir             => $back_directory,
    user                    => $back_user,
    public_register_enabled => $public_register_enabled,
    ldap_enable             => $ldap_enable,
    ldap_server             => $ldap_server,
    ldap_port               => $ldap_port,
    ldap_bind_dn            => $ldap_bind_dn,
    ldap_bind_password      => $ldap_bind_password,
    ldap_search_base        => $ldap_search_base,
    ldap_search_property    => $ldap_search_property,
    ldap_search_suffix      => $ldap_search_suffix,
    ldap_email_property     => $ldap_email_property,
    ldap_full_name_property => $ldap_full_name_property,
  }

  class { 'taiga::vhost':
    protocol        => $protocol,
    hostname        => $hostname,
    back_directory  => $back_directory,
    front_directory => $front_directory,
    back_user       => $back_user,
    ssl_cert        => $ssl_cert,
    ssl_key         => $ssl_key,
    ssl_chain       => $ssl_chain,
  }

  Class['taiga::back::repo'] -> Class['taiga::vhost']
}
