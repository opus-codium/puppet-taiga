class taiga::back::dependencies {
  $depends = ['build-essential', 'binutils-doc', 'autoconf', 'flex', 'bison', 'libjpeg-dev', 'libfreetype6-dev', 'libzmq3-dev', 'libgdbm-dev', 'libncurses5-dev', 'automake', 'libtool', 'libffi-dev', 'curl', 'gettext', 'python3', 'python3-pip', 'python-dev', 'python3-dev', 'python-pip', 'virtualenvwrapper', 'libxml2-dev', 'libxslt1-dev']

  package { $depends:
    ensure => installed,
  }
}
