class taiga::back::params {
  case $::osfamily {
    'debian': {
      $python_path = '/usr/bin/python'
      case $::lsbdistcodename {
        'jessie': {
          $python_version = '3.4'
        }
        'stretch': {
          $python_version = '3.5'
        }
        default: {
          fail("unsupported lsbdistcodename ${::lsbdistcodename}")
        }
      }
      $virtualenv = '/usr/bin/virtualenv'
    }
    'freebsd': {
      $python_path = '/usr/local/bin/python'
      $python_version = '3.4'
      $virtualenv = '/usr/local/bin/virtualenv'
    }
    default: {
      fail("unsupported osfamily ${::osfamily}")
    }
  }
}
