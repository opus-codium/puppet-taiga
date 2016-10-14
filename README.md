# taiga

1. [Module Description - What the module does and why it is useful](#module-description)
3. [Usage - Configuration options and additional functionality](#usage)
    * [Installing a basic HTTP Taiga instance](#installing-a-basic-http-taiga-instance)
    * [Installing a secured HTTPS Taiga instance](#installing-a-secured-https-taiga-instance)
    * [Choosing which version to install](#choosing-which-version-to-install)
    * [Advanced configuration](#advanced-configuration)
4. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
    * [Classes](#classes)

## Module description

[Taiga](https://taiga.io/) is a project management platform.
This Puppet module simplifies the configuration of Taiga in your infrastructure.

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

### Classes

#### Public Classes

* [`taiga`](#class-taiga)
* [`taiga::back`](#class-taigaback)
* [`taiga::front`](#class-taigafront)
* [`taiga::vhost`](#class-taigavhost)

#### Class: `taiga`

Guides the basic setup and installation of Taiga on your system.

When this class is declared with the default options, Puppet:

* Installs apache;
* Installs PostgreSQL;
* Deploys `taiga-front`;
* Deploys `taiga-back`;
* Setup apache to serve them.

##### `hostname`

Sets the hostname that will be used to reach the Taiga instance.

##### `back_secret_key`

A secret key passed to the `SECRET_KEY` setting in taiga-back configuration. (A 60 characters random string should be a good start, you can generate one using `apg -a1 -m60`).

##### `back_db_password`

Sets the database password.  It is currently not used but still has to be provided.

##### `protocol`

Determines the protocol to be used, one of 'http' or 'https'.
Default: 'https'

##### `default_language`

Default: 'en'

##### `repo_revision`

Determines which version of Taiga should be deployed.
Can be a tag (e.g. '3.0.0') or a branch name (e.g. 'master')
Default: 'stable'.

##### `repo_ensure`

Determines if Taiga's repository should be checked to get a new version.  Can be set to 'latest' or 'present'.
Default: 'present'.

##### `back_directory`

Default '/srv/www/taiga-back'.

##### `front_directory`

Default: '/srv/www/taiga-front'

##### `back_user`

Default: 'taiga'

##### `public_register_enabled`

Default: true

##### `ldap_server`

Default: undef.

##### `ldap_port`

Default: 389.

##### `ldap_bind_dn`

Default: undef.

##### `ldap_bind_password`

Default: undef.

##### `ldap_search_base`

Default: 'ou=people,dc=example,dc=com'

##### `ldap_search_property`

Default: 'uid'

##### `ldap_search_suffix`

Default: undef.

##### `ldap_email_property`

Default: 'mail'

##### `ldap_full_name_property`

Default: 'cn'

##### `ssl_cert`

Default: undef.

##### `ssl_key`

Default: undef.

##### `ssl_chain`

Default: undef.

