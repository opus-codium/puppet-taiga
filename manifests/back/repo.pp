class taiga::back::repo {
  include ::taiga::back

  file { $taiga::back::install_dir:
    ensure => directory,
    owner  => $taiga::back::user,
    mode   => '0755',
  }
  -> vcsrepo { $taiga::back::install_dir:
    ensure   => $taiga::back::repo_ensure,
    provider => 'git',
    source   => 'https://github.com/taigaio/taiga-back.git',
    revision => $taiga::back::repo_revision,
    user     => $taiga::back::user,
  }
}
