class taiga::back::env {
  include taiga::back

  exec { 'taiga-back-virtualenv':
    command     => "/usr/bin/virtualenv -p /usr/bin/python3.4 ${taiga::back::install_dir}",
    creates     => "${taiga::back::install_dir}/lib",
    user        => $taiga::back::user,
  }

  exec { 'taiga-back-pip-install':
    command     => "${taiga::back::install_dir}/bin/pip install -r requirements.txt",
    cwd         => $taiga::back::install_dir,
    refreshonly => true,
    user        => $taiga::back::user,
    require     => Exec['taiga-back-virtualenv'],
  }
}
