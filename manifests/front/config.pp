class taiga::front::config {
  include taiga::front

  $ws_protocol = $taiga::front::back_protocol ? {
    'http'  => 'ws',
    'https' => 'wss',
  }

  file { "${taiga::front::install_dir}/dist/conf.json":
    ensure  => present,
    owner   => $taiga::front::user,
    mode    => '0644',
    content => template('taiga/front/conf.json.erb'),
  }
}
