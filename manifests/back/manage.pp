define taiga::back::manage {
  assert_private()

  exec { "taiga-back-migration-${name}":
    command     => "${taiga::back::install_dir}/bin/python manage.py ${name}",
    cwd         => $taiga::back::install_dir,
    user        => $taiga::back::user,
    refreshonly => true,
  }
}
