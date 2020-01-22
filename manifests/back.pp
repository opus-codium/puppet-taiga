# @summary Install Taiga back
#
# @param front_hostname
# @param front_protocol
# @param back_hostname
# @param back_protocol
# @param secret_key
# @param db_password
# @param dependencies
# @param db_name
# @param db_user
# @param user
# @param repo_ensure
# @param repo_revision
# @param install_dir
# @param public_register_enabled
# @param ldap_enable
# @param ldap_server
# @param ldap_port
# @param ldap_bind_dn
# @param ldap_bind_password
# @param ldap_search_base
# @param ldap_search_property
# @param ldap_search_suffix
# @param ldap_email_property
# @param ldap_full_name_property
# @param email_use_tls
# @param email_host
# @param email_port
# @param email_user
# @param email_password
# @param python_path
# @param python_version
# @param virtualenv
class taiga::back (
  String[1]                  $front_hostname,
  Enum['http', 'https']      $front_protocol,
  String[1]                  $back_hostname,
  Enum['http', 'https']      $back_protocol,
  String[1]                  $secret_key,
  String[1]                  $db_password,
  Array[String[1]]           $dependencies,
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
) {
  contain taiga::back::user
  contain taiga::back::dependencies
  contain taiga::back::repo
  contain taiga::back::env
  contain taiga::back::install
  contain taiga::back::config
  contain taiga::back::database
  contain taiga::back::migrate
  contain taiga::back::seed

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
    contain taiga::back::ldap

    Class['Taiga::Back::Env']
    ~> Class['Taiga::Back::Ldap']
  }

  Class['Taiga::Back::Config']
  ~> Class['Apache::Service']

  Class['Taiga::Back::Install']
  ~> Class['Apache::Service']
}
