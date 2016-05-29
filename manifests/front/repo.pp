class taiga::front::repo {
  include taiga::front

  file { $taiga::front::install_dir:
    ensure => directory,
    owner  => $taiga::front::user,
    mode   => '0755',
  } ->
  vcsrepo { $taiga::front::install_dir:
    ensure   => $taiga::front::repo_ensure,
    provider => 'git',
    source   => 'https://github.com/taigaio/taiga-front-dist.git',
    revision => $taiga::front::repo_revision,
    user     => $taiga::front::user,
  }
}
