class taiga::back (
  String $front_hostname,
  String $front_protocol,
  String $back_hostname,
  String $back_protocol,
  String $secret_key,
  String $db_password,
  String $db_name = 'taiga',
  String $db_user = 'taiga',
  String $user = 'taiga',
  String $repo_ensure = 'present',
  String $repo_revision = 'stable',
  String $install_dir = '/srv/www/taiga-back',
  Boolean $public_register_enabled = true,
  Boolean $ldap_enable = false,
  Optional[String] $ldap_server = undef,
  Integer $ldap_port = 389,
  Optional[String] $ldap_bind_dn = undef,
  Optional[String] $ldap_bind_password = undef,
  String $ldap_search_base = 'ou=people,dc=example,dc=com',
  String $ldap_search_property = 'uid',
  Optional[String] $ldap_search_suffix = undef,
  String $ldap_email_property = 'mail',
  String $ldap_full_name_property = 'cn',
  Boolean $email_use_tls = false,
  String $email_host = 'localhost',
  Integer $email_port = 25,
  Optional[String] $email_user = undef,
  Optional[String] $email_password = undef,
  String $python_path = $taiga::back::params::python_path,
  String $python_version = $taiga::back::params::python_version,
  String $virtualenv = $taiga::back::params::virtualenv,
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
