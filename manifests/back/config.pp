class taiga::back::config {
  include taiga::back

  concat { "${taiga::back::install_dir}/settings/local.py":
    ensure => present,
    owner  => $taiga::back::user,
    group  => 'nogroup',
  }

  concat::fragment { 'taiga-back-local.py-base':
    target  => "${taiga::back::install_dir}/settings/local.py",
    content => template('taiga/back/local.py.erb'),
    order   => '00',
  }
}
