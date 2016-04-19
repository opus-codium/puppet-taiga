class taiga::back::repo {
  include taiga::back

  file { $taiga::back::install_dir:
    ensure => directory,
    owner  => $taiga::back::user,
    mode   => '0755',
  } ->
  vcsrepo { $taiga::back::install_dir:
    ensure   => present,
    provider => 'git',
    source   => 'https://github.com/taigaio/taiga-back.git',
    revision => 'stable',
    user     => $taiga::back::user,
    notify   => Exec['taiga-back-pip-install'],
  }
}
