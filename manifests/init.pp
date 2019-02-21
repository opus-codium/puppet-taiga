class taiga (
  String[1]                      $hostname,
  String[1]                      $back_secret_key,
  String[1]                      $back_db_password,
  Enum['http', 'https']          $protocol = 'https',
  String[2, 2]                   $default_language = 'en',
  Enum['present', 'latest']      $repo_ensure = 'present',
  String[1]                      $repo_revision = 'stable',
  Stdlib::Absolutepath           $back_directory = '/srv/www/taiga-back',
  Stdlib::Absolutepath           $front_directory = '/srv/www/taiga-front',
  String[1]                      $back_user = 'taiga',
  Boolean                        $public_register_enabled = true,
  Boolean                        $gravatar = true,
  Optional[String[1]]            $ldap_server = undef,
  Integer                        $ldap_port = 389,
  Optional[String[1]]            $ldap_bind_dn = undef,
  Optional[String[1]]            $ldap_bind_password = undef,
  String[1]                      $ldap_search_base = 'ou=people,dc=example,dc=com',
  String[1]                      $ldap_search_property = 'uid',
  Optional[String[1]]            $ldap_search_suffix = undef,
  String[1]                      $ldap_email_property = 'mail',
  String[1]                      $ldap_full_name_property = 'cn',
  Optional[Stdlib::Absolutepath] $ssl_cert = undef,
  Optional[Stdlib::Absolutepath] $ssl_key = undef,
  Optional[Stdlib::Absolutepath] $ssl_chain = undef,
) {
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
