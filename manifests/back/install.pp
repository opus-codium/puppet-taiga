class taiga::back::install {
  include taiga::back

  exec { 'taiga-back-pip-install':
    command     => "${taiga::back::install_dir}/bin/pip install --requirement requirements.txt --upgrade",
    cwd         => $taiga::back::install_dir,
    refreshonly => true,
    user        => $taiga::back::user,
  }
}
