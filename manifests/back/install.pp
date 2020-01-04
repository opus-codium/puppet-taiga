class taiga::back::install {
  assert_private()

  exec { 'taiga-back-upgrade-pip':
    command     => "${taiga::back::install_dir}/bin/pip install --upgrade pip",
    cwd         => $taiga::back::install_dir,
    refreshonly => true,
    user        => $taiga::back::user,
  }

  exec { 'taiga-back-upgrade-setuptools':
    command     => "${taiga::back::install_dir}/bin/pip install --upgrade setuptools",
    cwd         => $taiga::back::install_dir,
    refreshonly => true,
    user        => $taiga::back::user,
  }

  exec { 'taiga-back-pip-install':
    command     => "${taiga::back::install_dir}/bin/pip install --requirement requirements.txt --upgrade",
    cwd         => $taiga::back::install_dir,
    refreshonly => true,
    user        => $taiga::back::user,
    timeout     => 0,
  }

  Exec['taiga-back-upgrade-pip']
  -> Exec['taiga-back-upgrade-setuptools']
  -> Exec['taiga-back-pip-install']
}
