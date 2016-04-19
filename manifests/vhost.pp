class taiga::vhost (
  $protocol,
  $hostname,
  $back_directory,
  $front_directory,
  $back_user,
) {
  case $protocol {
    'http': {
      $port = 80
      $ssl = false
    }
    'https': {
      $port = 443
      $ssl = true
    }
    default: {
      fail("Unknown protocol '${protocol}'")
    }
  }

  file { "${back_directory}/passenger_wsgi.py":
    ensure  => present,
    owner   => 'root',
    mode    => '755',
    content => template('taiga/vhost/passenger_wsgi.py.erb'),
  }

  apache::vhost { $hostname:
    port            => $port,
    docroot         => "${front_directory}/dist",
    manage_docroot  => false,
    ssl             => $ssl,

    aliases         => [
      {
        alias => '/media',
        path  => "${back_directory}/media",
      },
      {
        alias => '/static',
        path  => "${back_directory}/static",
      },
    ],

    error_documents => [
      {
        'error_code' => '404',
        'document'   => '/index.html',
      },
    ],
    custom_fragment => "
<Location /api>
    PassengerBaseURI /
    PassengerAppRoot ${back_directory}
    PassengerAppType wsgi
    PassengerStartupFile passenger_wsgi.py
    PassengerUser ${back_user}
</Location>
<Location /admin>
    PassengerBaseURI /
    PassengerAppRoot ${back_directory}
    PassengerAppType wsgi
    PassengerStartupFile passenger_wsgi.py
    PassengerUser ${back_user}

    Require ip 127.0.0.1
    Require ip ::1
</Location>
",
  }
}
