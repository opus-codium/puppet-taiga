class taiga (
  String $hostname,
  String $back_secret_key,
  String $back_db_password,
  String $protocol = 'https',
  String $default_language = 'en',
  String $repo_ensure = 'present',
  String $repo_revision = 'stable',
  String $back_directory = '/srv/www/taiga-back',
  String $front_directory = '/srv/www/taiga-front',
  String $back_user = 'taiga',
  Boolean $public_register_enabled = true,
  Boolean $gravatar = true,
  Optional[String] $ldap_server = undef,
  Integer $ldap_port = 389,
  Optional[String] $ldap_bind_dn = undef,
  Optional[String] $ldap_bind_password = undef,
  String $ldap_search_base = 'ou=people,dc=example,dc=com',
  String $ldap_search_property = 'uid',
  Optional[String] $ldap_search_suffix = undef,
  String $ldap_email_property = 'mail',
  String $ldap_full_name_property = 'cn',
  Optional[String] $ssl_cert = undef,
  Optional[String] $ssl_key = undef,
  Optional[String] $ssl_chain = undef,
) {
  validate_string($hostname)
  validate_string($back_secret_key)
  validate_string($back_db_password)
  validate_re($protocol, 'https?')
  validate_string($default_language)
  validate_re($repo_ensure, ['^present$', '^latest$'])
  validate_absolute_path($back_directory)
  validate_absolute_path($front_directory)
  validate_string($back_user)
  validate_bool($public_register_enabled)

  $ldap_enable = $ldap_server ? {
    undef   => false,
    default => true,
  }

  class { 'taiga::front':
    back_hostname           => $hostname,
    back_protocol           => $protocol,
    default_language        => $default_language,
    repo_ensure             => $repo_ensure,
    repo_revision           => $repo_revision,
    install_dir             => $front_directory,
    public_register_enabled => $public_register_enabled,
    ldap_enable             => $ldap_enable,
    gravatar                => $gravatar,
  }
  class { 'taiga::back':
    front_hostname          => $hostname,
    front_protocol          => $protocol,
    back_hostname           => $hostname,
    back_protocol           => $protocol,
    secret_key              => $back_secret_key,
    db_password             => $back_db_password,
    repo_ensure             => $repo_ensure,
    repo_revision           => $repo_revision,
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

  Class['Taiga::Back::Repo']
  -> Class['Taiga::Vhost']
}
