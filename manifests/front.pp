class taiga::front (
  String $back_hostname,
  String $back_protocol,
  Boolean $events = false,
  String $user = 'nobody',
  String $repo_ensure = 'present',
  String $repo_revision = 'stable',
  String $install_dir = '/srv/www/taiga-front',
  String $default_language = 'en',
  Boolean $public_register_enabled = true,
  Boolean $ldap_enable = false,
  Boolean $gravatar = true,
) {
  include ::taiga::front::repo
  include ::taiga::front::config

  Class['Taiga::Front::Repo']
  -> Class['Taiga::Front::Config']
}
