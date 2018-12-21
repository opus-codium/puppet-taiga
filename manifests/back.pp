class taiga::back (
  String[1]                  $front_hostname,
  Enum['http', 'https']      $front_protocol,
  String[1]                  $back_hostname,
  Enum['http', 'https']      $back_protocol,
  String[1]                  $secret_key,
  String[1]                  $db_password,
  String[1]                  $db_name = 'taiga',
  String[1]                  $db_user = 'taiga',
  String[1]                  $user = 'taiga',
  Enum['present', 'latest']  $repo_ensure = 'present',
  String[1]                  $repo_revision = 'stable',
  Stdlib::Absolutepath       $install_dir = '/srv/www/taiga-back',
  Boolean                    $public_register_enabled = true,
  Boolean                    $ldap_enable = false,
  Optional[String[1]]        $ldap_server = undef,
  Integer                    $ldap_port = 389,
  Optional[String[1]]        $ldap_bind_dn = undef,
  Optional[String[1]]        $ldap_bind_password = undef,
  String[1]                  $ldap_search_base = 'ou=people,dc=example,dc=com',
  String[1]                  $ldap_search_property = 'uid',
  Optional[String[1]]        $ldap_search_suffix = undef,
  String[1]                  $ldap_email_property = 'mail',
  String[1]                  $ldap_full_name_property = 'cn',
  Boolean                    $email_use_tls = false,
  String[1]                  $email_host = 'localhost',
  Integer                    $email_port = 25,
  Optional[String[1]]        $email_user = undef,
  Optional[String[1]]        $email_password = undef,
  Stdlib::Absolutepath       $python_path = $taiga::back::params::python_path,
  String[1]                  $python_version = $taiga::back::params::python_version,
  Stdlib::Absolutepath       $virtualenv = $taiga::back::params::virtualenv,
) inherits taiga::back::params {
  include ::taiga::back::user
  include ::taiga::back::dependencies
  include ::taiga::back::repo
  include ::taiga::back::env
  include ::taiga::back::install
  include ::taiga::back::config
  include ::taiga::back::database
  include ::taiga::back::migrate
  include ::taiga::back::seed

  Class['Taiga::Back::User']
  -> Class['Taiga::Back::Dependencies']
  -> Class['Taiga::Back::Repo']
  -> Class['Taiga::Back::Env']
  -> Class['Taiga::Back::Install']
  -> Class['Taiga::Back::Config']
  -> Class['Taiga::Back::Database']
  -> Class['Taiga::Back::Migrate']
  -> Class['Taiga::Back::Seed']

  Class['Taiga::Back::Repo']
  ~> Class['Taiga::Back::Install']

  Class['Taiga::Back::Repo']
  ~> Class['Taiga::Back::Migrate']

  Class['Taiga::Back::Database']
  ~> Class['Taiga::Back::Migrate']
  ~> Class['Taiga::Back::Seed']

  if $ldap_enable {
    include ::taiga::back::ldap

    Class['Taiga::Back::Env']
    ~> Class['Taiga::Back::Ldap']
  }

  Class['Taiga::Back::Config']
  ~> Class['Apache::Service']

  Class['Taiga::Back::Install']
  ~> Class['Apache::Service']
}
