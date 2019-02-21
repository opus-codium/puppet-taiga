class taiga::front (
  String[1]                 $back_hostname,
  Enum['http', 'https']     $back_protocol,
  Boolean                   $events = false,
  String[1]                 $user = 'nobody',
  Enum['present', 'latest'] $repo_ensure = 'present',
  String[1]                 $repo_revision = 'stable',
  Stdlib::Absolutepath      $install_dir = '/srv/www/taiga-front',
  String[2, 2]              $default_language = 'en',
  Boolean                   $public_register_enabled = true,
  Boolean                   $ldap_enable = false,
  Boolean                   $gravatar = true,
) {
  include ::taiga::front::repo
  include ::taiga::front::config

  Class['Taiga::Front::Repo']
  -> Class['Taiga::Front::Config']
}
