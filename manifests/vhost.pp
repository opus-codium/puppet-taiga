# @summary Configure an apache Virtual Host for taiga
#
# @param protocol
# @param hostname
# @param back_directory
# @param front_directory
# @param back_user
# @param ssl_cert
# @param ssl_key
# @param ssl_chain
class taiga::vhost (
  Enum['http', 'https'] $protocol,
  String[1]             $hostname,
  Stdlib::Absolutepath  $back_directory,
  Stdlib::Absolutepath  $front_directory,
  String[1]             $back_user,
  Optional[String[1]]   $ssl_cert = undef,
  Optional[String[1]]   $ssl_key = undef,
  Optional[String[1]]   $ssl_chain = undef,
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
    mode    => '0755',
    content => template('taiga/vhost/passenger_wsgi.py.erb'),
  }

  include ::apache
  include ::apache::mod::passenger

  apache::vhost { $hostname:
    port                       => $port,
    docroot                    => "${front_directory}/dist",
    manage_docroot             => false,
    ssl                        => $ssl,
    ssl_cert                   => $ssl_cert,
    ssl_key                    => $ssl_key,
    ssl_chain                  => $ssl_chain,

    aliases                    => [
      {
        alias => '/media',
        path  => "${back_directory}/media",
      },
      {
        alias => '/static',
        path  => "${back_directory}/static",
      },
    ],

    fallbackresource           => '/index.html',

    passenger_high_performance => false,

    directories                => [
      {
        path           => "${front_directory}/dist",
        options        => 'None',
        allow_override => 'None',
      },
      {
        path                   => '/api',
        provider               => 'location',
        fallbackresource       => 'disabled',
        passenger_base_uri     => '/',
        passenger_app_root     => $back_directory,
        passenger_app_type     => 'wsgi',
        passenger_startup_file => 'passenger_wsgi.py',
        passenger_python       => "${back_directory}/bin/python",
        passenger_user         => $back_user,
      },
      {
        path                   => '/admin',
        provider               => 'location',
        fallbackresource       => 'disabled',
        passenger_base_uri     => '/admin',
        passenger_app_root     => $back_directory,
        passenger_app_type     => 'wsgi',
        passenger_startup_file => 'passenger_wsgi.py',
        passenger_python       => "${back_directory}/bin/python",
        passenger_user         => $back_user,
        require                => [
          '127.0.0.1',
          '::1',
          $facts['ipaddress'],
          $facts['ipaddress6'],
        ].filter |$ip| { ! $ip.empty }.map |$ip| { "ip ${ip}" },
      },
    ],
  }
}
