# Taiga

## Module description

[Taiga](https://taiga.io/) is a project management platform.
This Puppet module simplifies the configuration of Taiga in your infrastructure.

### Beginning with Taiga

In order to install `taiga-back`, `taiga-front` and an apache virtual host, the following is enough:

~~~puppet
class { '::taiga':
  hostname         => 'taiga.io',
  back_secret_key  => 'secret',
  back_db_password => 'secret',  # currently unused
}
~~~

### Public Classes

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

