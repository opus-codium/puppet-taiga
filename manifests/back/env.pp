class taiga::back::env {
  include ::taiga::back

  exec { 'taiga-back-virtualenv':
    command => "${taiga::back::virtualenv} -p ${taiga::back::python_path}${taiga::back::python_version} ${taiga::back::install_dir}",
    creates => "${taiga::back::install_dir}/lib/python${taiga::back::python_version}/site-packages/django",
    user    => $taiga::back::user,
  }
}
