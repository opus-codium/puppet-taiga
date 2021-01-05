# @summary Install taiga front
#
# @param back_hostname Hostname used to reach the backend.
# @param back_protocol Protocol used to reach the backend.
# @param events
# @param user Name of the user owning the files of the frontend.
# @param repo_ensure Ensure value for Taiga's vcs repository.
# @param repo_revision Revision for Taiga's vcs repository.
# @param install_dir Directory where is installed the frontend of Taiga.
# @param default_language Default language.
# @param public_register_enabled Enable anyone to register on this instance.
# @param ldap_enable Enable the LDAP client.
# @param gravatar Use gravatar.
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
  include taiga::front::repo
  include taiga::front::config

  Class['Taiga::Front::Repo']
  -> Class['Taiga::Front::Config']
}
