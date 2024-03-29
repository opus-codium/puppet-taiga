# @summary Manage the Taiga back repository
#
# @api private
class taiga::back::repo {
  assert_private()

  file { $taiga::back::install_dir:
    ensure => directory,
    owner  => $taiga::back::user,
    mode   => '0755',
  }
  -> vcsrepo { $taiga::back::install_dir:
    ensure   => $taiga::back::repo_ensure,
    provider => 'git',
    source   => 'https://github.com/kaleidos-ventures/taiga-back.git',
    revision => $taiga::back::repo_revision,
    user     => $taiga::back::user,
  }
}
