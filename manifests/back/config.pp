class taiga::back::config {
  include taiga::back

  $front_hostname = $taiga::back::front_hostname
  $front_protocol = $taiga::back::front_protocol

  $back_hostname = $taiga::back::back_hostname
  $back_protocol = $taiga::back::back_protocol

  $secret_key = $taiga::back::secret_key

  file { "${taiga::back::install_dir}/settings/local.py":
    ensure  => present,
    owner   => $taiga::back::user,
    group   => 'nogroup',
    content => template('taiga/back/local.py.erb'),
  }
}
