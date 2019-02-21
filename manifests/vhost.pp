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
    port             => $port,
    docroot          => "${front_directory}/dist",
    manage_docroot   => false,
    ssl              => $ssl,
    ssl_cert         => $ssl_cert,
    ssl_key          => $ssl_key,
    ssl_chain        => $ssl_chain,

    aliases          => [
      {
        alias => '/media',
        path  => "${back_directory}/media",
      },
      {
        alias => '/static',
        path  => "${back_directory}/static",
      },
    ],

    fallbackresource => '/index.html',
    custom_fragment  => inline_template('
<Location /api>
    PassengerBaseURI /
    PassengerAppRoot <%= @back_directory %>
    PassengerAppType wsgi
    PassengerStartupFile passenger_wsgi.py
    PassengerPython <%= @back_directory %>/bin/python
    PassengerUser <%= @back_user %>
    FallbackResource disabled
</Location>
<Location /admin>
    PassengerBaseURI /
    PassengerAppRoot <%= @back_directory %>
    PassengerAppType wsgi
    PassengerStartupFile passenger_wsgi.py
    PassengerUser <%= @back_user %>
    FallbackResource disabled

    Require ip 127.0.0.1
    Require ip ::1
    <%- if @ipaddress -%>
    Require ip <%= @ipaddress %>
    <%- end -%>
    <%- if @ipaddress6 -%>
    Require ip <%= @ipaddress6 %>
    <%- end -%>
</Location>
'),
  }
}
