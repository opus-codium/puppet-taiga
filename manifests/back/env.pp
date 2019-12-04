class taiga::back::env {
  include ::taiga::back

  exec { 'taiga-back-virtualenv':
    command => "${taiga::back::virtualenv} -p ${taiga::back::python_path}${taiga::back::python_version} ${taiga::back::install_dir}",
    creates => "${taiga::back::install_dir}/bin/python${taiga::back::python_version}",
    user    => $taiga::back::user,
    notify  => [
      Class['taiga::back::install'],
      Class['taiga::back::migrate'],
    ],
  }
}
