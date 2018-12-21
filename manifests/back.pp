class taiga::back (
  $front_hostname,
  $front_protocol,
  $back_hostname,
  $back_protocol,
  $secret_key,
  $db_password,
  $db_name = 'taiga',
  $db_user = 'taiga',
  $user = 'taiga',
  $repo_ensure = 'present',
  $repo_revision = 'stable',
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
  $python_path = $taiga::back::params::python_path,
  $python_version = $taiga::back::params::python_version,
  $virtualenv = $taiga::back::params::virtualenv,
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
