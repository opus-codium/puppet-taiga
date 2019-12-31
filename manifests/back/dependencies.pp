class taiga::back::dependencies {
  case $::osfamily {
    'Debian': {
      $depends = [
        'autoconf',
        'automake',
        'binutils-doc',
        'bison',
        'build-essential',
        'curl',
        'flex',
        'gettext',
        'libffi-dev',
        'libfreetype6-dev',
        'libgdbm-dev',
        'libjpeg-dev',
        'libncurses5-dev',
        'libpq-dev',
        'libssl-dev',
        'libtool',
        'libxml2-dev',
        'libxslt1-dev',
        'libzmq3-dev',
        'python-dev',
        'python-pip',
        'python3',
        'python3-dev',
        'python3-pip',
        'virtualenvwrapper',
      ]
    }
    'FreeBSD': {
      $depends = [
        'libxml2',
        'libxslt',
        'py37-virtualenvwrapper',
        'python3',
      ]
    }
    default: {
      fail("Unsupported operating system: ${::osfamily}")
    }
  }

  ensure_packages($depends, {
    ensure => installed,
  })
}
