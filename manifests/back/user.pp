class taiga::back::user {
  include ::taiga::back

  user { $taiga::back::user:
    ensure => present,
    home   => $taiga::back::install_dir,
    system => true,
    notify => Exec['taiga-back-pip-install'],
    shell  => '/bin/sh',
  }
}
