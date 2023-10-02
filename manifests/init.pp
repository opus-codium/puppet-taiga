# @summary Install both Taiga front, back and setup an apache Virtual Host
#
# @param hostname Hostname that will be used to reach the Taiga instance.
# @param back_secret_key A secret key passed to the `SECRET_KEY` setting in taiga-back configuration. (A 60 characters random string should be a good start).
# @param back_db_password Sets the database password. It is currently not used but still has to be provided.
# @param protocol Protocol to be used.
# @param default_language Default language.
# @param repo_ensure Ensure value for Taiga's vcs repository.
# @param repo_revision Revision for Taiga's vcs repository.
# @param back_directory Directory where is installed the backend of Taiga.
# @param venv_directory Default where is installed python dependencies.
# @param front_directory Directory where is installed the frontend of Taiga.
# @param back_user Name of the user running the backend daemon.
# @param back_admins Administrators to notify of Taiga exceptions.
# @param public_register_enabled Enable anyone to register on this instance.
# @param gravatar Use gravatar.
# @param ldap_server LDAP server.
# @param ldap_port LDAP port.
# @param ldap_bind_dn DN to use for LDAP authentication.
# @param ldap_bind_password Password to use for LDAP authentication.
# @param ldap_search_base Search base for users.
# @param ldap_search_property Property holding users login.
# @param ldap_search_suffix
# @param ldap_email_property Property holding users e-mail.
# @param ldap_full_name_property Property holding users full name.
# @param ssl_cert Certificate to use for apache VirtualHost.
# @param ssl_key Key to use for apache VirtualHost.
# @param ssl_chain Certificate chain to use for apache VirtualHost.
# @param change_notification_min_interval Interval for sending change notifications.
# @param default_project_slug_prefix Add username to project slug
class taiga (
  String[1]                      $hostname,
  String[1]                      $back_secret_key,
  String[1]                      $back_db_password,
  Enum['http', 'https']          $protocol = 'https',
  String[2, 2]                   $default_language = 'en',
  Enum['present', 'latest']      $repo_ensure = 'present',
  String[1]                      $repo_revision = 'stable',
  Stdlib::Absolutepath           $back_directory = '/srv/www/taiga-back',
  Stdlib::Absolutepath           $venv_directory = '/srv/www/taiga-venv',
  Stdlib::Absolutepath           $front_directory = '/srv/www/taiga-front',
  String[1]                      $back_user = 'taiga',
  Array[Taiga::Admin]            $back_admins = [],
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
  Optional[Integer]              $change_notification_min_interval = undef,
  Optional[Boolean]              $default_project_slug_prefix = undef,
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
    front_hostname                   => $hostname,
    front_protocol                   => $protocol,
    back_hostname                    => $hostname,
    back_protocol                    => $protocol,
    admins                           => $back_admins,
    secret_key                       => $back_secret_key,
    db_password                      => $back_db_password,
    repo_ensure                      => $repo_ensure,
    repo_revision                    => $repo_revision,
    install_dir                      => $back_directory,
    venv_dir                         => $venv_directory,
    user                             => $back_user,
    public_register_enabled          => $public_register_enabled,
    ldap_enable                      => $ldap_enable,
    ldap_server                      => $ldap_server,
    ldap_port                        => $ldap_port,
    ldap_bind_dn                     => $ldap_bind_dn,
    ldap_bind_password               => $ldap_bind_password,
    ldap_search_base                 => $ldap_search_base,
    ldap_search_property             => $ldap_search_property,
    ldap_search_suffix               => $ldap_search_suffix,
    ldap_email_property              => $ldap_email_property,
    ldap_full_name_property          => $ldap_full_name_property,
    change_notification_min_interval => $change_notification_min_interval,
    default_project_slug_prefix      => $default_project_slug_prefix,
  }

  class { 'taiga::vhost':
    protocol        => $protocol,
    hostname        => $hostname,
    back_directory  => $back_directory,
    venv_directory  => $venv_directory,
    front_directory => $front_directory,
    back_user       => $back_user,
    ssl_cert        => $ssl_cert,
    ssl_key         => $ssl_key,
    ssl_chain       => $ssl_chain,
  }

  Class['Taiga::Back::Repo']
  -> Class['Taiga::Vhost']
}
