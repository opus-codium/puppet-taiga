# @summary Install Taiga back
#
# @param front_hostname Hostname used to reach the frontend.
# @param front_protocol Protocol used to reach the frontend.
# @param back_hostname Hostname used to reach the backend.
# @param back_protocol Protocol used to reach the backend.
# @param secret_key A secret key passed to the `SECRET_KEY` setting in taiga-back configuration. (A 60 characters random string should be a good start).
# @param db_password Sets the database password. It is currently not used but still has to be provided.
# @param dependencies Extra depepdencies.
# @param db_name Name of the database.
# @param db_user User of the database.
# @param user Name of the user running the backend daemon.
# @param repo_ensure Ensure value for Taiga's vcs repository.
# @param repo_revision Revision for Taiga's vcs repository.
# @param install_dir Directory where is installed the backend of Taiga.
# @param public_register_enabled Enable anyone to register on this instance.
# @param ldap_enable Enable the LDAP client.
# @param ldap_server LDAP server.
# @param ldap_port LDAP port.
# @param ldap_bind_dn DN to use for LDAP authentication.
# @param ldap_bind_password Password to use for LDAP authentication.
# @param ldap_search_base Search base for users.
# @param ldap_search_property Property holding users login.
# @param ldap_search_suffix
# @param ldap_email_property Property holding users e-mail.
# @param ldap_full_name_property Property holding users full name.
# @param email_use_tls Use TLS to connect to the mail server.
# @param email_host Hostname of the mail server.
# @param email_port Port of the mail server.
# @param email_user Username to authenticate on the mail server.
# @param email_password Password to authenticate on the mail server.
# @param python_path Path to Python.
# @param python_version Version of Python.
# @param virtualenv Path to virtualenv.
# @param change_notification_min_interval Interval for sending change notifications.
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
  Optional[Integer]          $change_notification_min_interval = undef,
) {
  contain taiga::back::user
  contain taiga::back::dependencies
  contain taiga::back::repo
  contain taiga::back::env
  contain taiga::back::install
  contain taiga::back::config
  contain taiga::back::cron
  contain taiga::back::database
  contain taiga::back::migrate
  contain taiga::back::seed

  Class['Taiga::Back::User']
  -> Class['Taiga::Back::Dependencies']
  -> Class['Taiga::Back::Repo']
  -> Class['Taiga::Back::Env']
  -> Class['Taiga::Back::Install']
  -> Class['Taiga::Back::Config']
  -> Class['Taiga::Back::Cron']
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
