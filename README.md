# taiga

1. [Module Description - What the module does and why it is useful](#module-description)
3. [Usage - Configuration options and additional functionality](#usage)
    * [Installing a basic HTTP Taiga instance](#installing-a-basic-http-taiga-instance)
    * [Installing a secured HTTPS Taiga instance](#installing-a-secured-https-taiga-instance)
    * [Choosing which version to install](#choosing-which-version-to-install)
    * [Advanced configuration](#advanced-configuration)
4. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
    * [Public Classes](#public-classes)
    * [Private Classes](#private-classes)
    * [Defined Types](#defined-types)

## Module description

[Taiga](https://taiga.io/) is a project management platform.
This Puppet module simplifies the installation and configuration of Taiga in your infrastructure.

## Usage

### Installing a basic HTTP Taiga instance

In order to install `taiga-back`, `taiga-front` and an apache virtual host, the following is enough:

```puppet
class { '::taiga':
  hostname         => 'taiga.io',
  protocol         => 'http',
  back_secret_key  => 'secret',
  back_db_password => 'secret',  # currently unused
}
```

### Installing a secured HTTPS Taiga instance

```puppet
class { '::taiga':
  hostname         => 'taiga.io',
  back_secret_key  => 'secret',
  back_db_password => 'secret',  # currently unused
  ssl_key          => '/path/to/key.pem',
  ssl_cert         => '/path/to/certificate.pem',
  ssl_chain        => '/path/to/ca/chain.pem',
}
```

### Choosing which version to install

By default, the module will install the latest stable release and keepit untouched.  If you prefer to install a given release, you can do the following:

```puppet
class { '::taiga':
  # [...]
  repo_revision => '2.1.0',
}
```

If you want to track the stable branch:

```puppet
class { '::taiga':
  # [...]
  repo_ensure   => 'latest',
  repo_revision => 'stable',
}
```

If you like the danged:

```puppet
class { '::taiga':
  # [...]
  repo_ensure   => 'latest',
  repo_revision => 'master',
}
```

### Advanced configuration

Instead of using the `taiga` class, rely on the `taiga::front` and `taiga::back` classes.  This allows you to have a full controll on both the front and the back, and run for example the back on a node, and servce the front from another.

## Reference

* [Public classes](#public-classes)
    * [`taiga`](#class-taiga)
    * [`taiga::back`](#class-taigaback)
    * [`taiga::front`](#class-taigafront)
    * [`taiga::vhost`](#class-taigavhost)
* [Private classes](#private-classes)
    * `taiga::back::config`
    * `taiga::back::database`
    * `taiga::back::dependencies`
    * `taiga::back::env`
    * `taiga::back::install`
    * `taiga::back::ldap`
    * `taiga::back::manage`
    * `taiga::back::migrate`
    * `taiga::back::repo`
    * `taiga::back::seed`
    * `taiga::back::user`
    * `taiga::front::config`
    * `taiga::front::repo`

### Public Classes

#### Class: `taiga`

Installs and configure taiga-back, taiga-front and setup Apache to make the instance usable.

**Parameters within `taiga`:**

##### `back_db_password`

Sets the database password.  It is currently not used but still has to be provided.

##### `back_directory`

Default '/srv/www/taiga-back'.

##### `back_secret_key`

A secret key passed to the `SECRET_KEY` setting in taiga-back configuration. (A 60 characters random string should be a good start, you can generate one using `apg -a1 -m60`).

##### `back_user`

Default: 'taiga'

##### `default_language`

Default: 'en'

##### `front_directory`

Default: '/srv/www/taiga-front'

##### `gravatar`

Default: 'true'

##### `hostname`

Sets the hostname that will be used to reach the Taiga instance.

##### `ldap_bind_dn`

Default: undef.

##### `ldap_bind_password`

Default: undef.

##### `ldap_email_property`

Default: 'mail'

##### `ldap_full_name_property`

Default: 'cn'

##### `ldap_port`

Default: 389.

##### `ldap_search_base`

Default: 'ou=people,dc=example,dc=com'

##### `ldap_search_property`

Default: 'uid'

##### `ldap_search_suffix`

Default: undef.

##### `ldap_server`

Default: undef.

##### `protocol`

Determines the protocol to be used, one of 'http' or 'https'.
Default: 'https'

##### `public_register_enabled`

Default: true

##### `repo_ensure`

Determines if Taiga's repository should be checked to get a new version.  Can be set to 'latest' or 'present'.
Default: 'present'.

##### `repo_revision`

Determines which version of Taiga should be deployed.
Can be a tag (e.g. '3.0.0') or a branch name (e.g. 'master')
Default: 'stable'.

##### `ssl_cert`

Default: undef.

##### `ssl_chain`

Default: undef.

##### `ssl_key`

Default: undef.

#### Class: `taiga::back`

Installs and configure taiga-back.

**Parameters within `taiga::back`:**

##### `back_hostname`

##### `back_protocol`

##### `db_name`

Default: 'taiga'

##### `db_password`

##### `db_user`

Default: 'taiga'

##### `email_host`

Default: 'localhost'

##### `email_port`

Default: '25'

##### `email_use_tls`

Default: 'false'

##### `email_user`

Default: 'undef'

##### `front_hostname`

##### `front_protocol`

##### `install_dir`

Default: '/srv/www/taiga-back'

##### `ldap_bind_dn`

Default: 'undef'

##### `ldap_bind_password`

Default: 'undef'

##### `ldap_email_property`

Default: 'mail'

##### `ldap_enable`

Default: 'false'

##### `ldap_full_name_property`

Default: 'cn'

##### `ldap_port`

Default: '389'

##### `ldap_search_base`

Default: 'ou=people,dc=example,dc=com'

##### `ldap_search_property`

Default: 'uid'

##### `ldap_search_suffix`

Default: 'undef'

##### `ldap_server`

Default: 'undef'

##### `public_register_enabled`

Default: 'true'

##### `repo_ensure`

Default: 'present'

##### `repo_revision`

Default: 'stable'

##### `secret_key`

##### `user`

Default: 'taiga'

##### `email_password`

Default: 'undef'

#### Class: `taiga::front`

Installs and configure taiga-front.

**Parameters within `taiga::front`:**

##### `back_hostname`

##### `back_protocol`

##### `default_language`

Default: 'en'

##### `events`

Default: 'false'

##### `install_dir`

Default: '/srv/www/taiga-front'

##### `ldap_enable`

Default: 'false'

##### `public_register_enabled`

Default: 'true'

##### `repo_ensure`

Default: 'present'

##### `repo_revision`

Default: 'stable'

##### `user`

Default: 'nobody'

##### `gravatar`

Default: 'true'

#### Class: `taiga::vhost`

Configure an Apache Virtual Host to serve taiga-back and taiga-front.

**Parameters within `taiga::vhost`:**

##### `back_directory`

##### `back_user`

##### `front_directory`

##### `hostname`

##### `protocol`

##### `ssl_cert`

Default: 'undef'

##### `ssl_key`

Default: 'undef'

##### `ssl_chain`

Default: 'undef'

### Private Classes

#### Class: `taiga::back::config`

Manage taiga-back configuration files.

#### Class: `taiga::back::database`

Setup taiga-back databse.

#### Class: `taiga::back::dependencies`

Ensure taiga-back dependencies are installed.

#### Class: `taiga::back::env`

Ensure Python's virtualenv is setup.

#### Class: `taiga::back::install`

Install taiga-back dependencies.

#### Class: `taiga::back::ldap`

Install the [`taiga-contrib-ldap-auth`](https://github.com/ensky/taiga-contrib-ldap-auth) LDAP authentication contrib.

#### Class: `taiga::back::migrate`

Perform post-installation operations.

#### Class: `taiga::back::repo`

Checkout taiga-back.

#### Class: `taiga::back::seed`

Perform database seeding.

#### Class: `taiga::back::user`

Setup the user account of the user running taiga-back.

#### Class: `taiga::front::config`

Manage taiga-front configuration files.

#### Class: `taiga::front::repo`

Checkout taiga-front.

### Defined Types

#### Defined type: `taiga::back::manage`

Allows running actions thourgh taiga-back's `manage.py` script.
