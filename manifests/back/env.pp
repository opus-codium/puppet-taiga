class taiga::back::env {
  include taiga::back

  $virtualenv = $::osfamily ? {
    'Debian'  => '/usr/bin/virtualenv',
    'FreeBSD' => '/usr/local/bin/virtualenv',
  }

  $python3 = $::osfamily ? {
    'Debian'  => '/usr/bin/python3.4',
    'FreeBSD' => '/usr/local/bin/python3.4',
  }

  exec { 'taiga-back-virtualenv':
    command => "${virtualenv} -p ${python3} ${taiga::back::install_dir}",
    creates => "${taiga::back::install_dir}/lib/python3.4/site-packages/django",
    user    => $taiga::back::user,
  }

  exec { 'taiga-back-pip-install':
    command     => "${taiga::back::install_dir}/bin/pip install -r requirements.txt",
    cwd         => $taiga::back::install_dir,
    refreshonly => true,
    user        => $taiga::back::user,
    require     => Exec['taiga-back-virtualenv'],
  }
}
