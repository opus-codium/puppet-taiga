# @summary Manage the Taiga back user
#
# @api private
class taiga::back::user {
  assert_private()

  user { $taiga::back::user:
    ensure => present,
    home   => $taiga::back::install_dir,
    system => true,
    notify => Exec['taiga-back-pip-install'],
    shell  => '/bin/sh',
  }
}
