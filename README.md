# taiga

<!-- header GFM -->
[![Build Status](https://img.shields.io/github/workflow/status/opus-codium/puppet-taiga/Release)](https://github.com/opus-codium/puppet-taiga/releases)
[![Puppet Forge](https://img.shields.io/puppetforge/v/opuscodium/taiga.svg)](https://forge.puppetlabs.com/opuscodium/taiga)
[![Puppet Forge - downloads](https://img.shields.io/puppetforge/dt/opuscodium/taiga.svg)](https://forge.puppetlabs.com/opuscodium/taiga)
[![Puppet Forge - endorsement](https://img.shields.io/puppetforge/e/opuscodium/taiga.svg)](https://forge.puppetlabs.com/opuscodium/taiga)
[![Puppet Forge - scores](https://img.shields.io/puppetforge/f/opuscodium/taiga.svg)](https://forge.puppetlabs.com/opuscodium/taiga)
[![License](https://img.shields.io/github/license/opus-codium/puppet-taiga.svg)](https://github.com/voxpupuli/opuscodium-taiga/blob/master/LICENSE.md)
<!-- header -->

#### Table of Contents

<!-- vim-markdown-toc GFM -->

* [Module description](#module-description)
* [Usage](#usage)
  * [Installing a basic HTTP Taiga instance](#installing-a-basic-http-taiga-instance)
  * [Installing a secured HTTPS Taiga instance](#installing-a-secured-https-taiga-instance)
  * [Choosing which version to install](#choosing-which-version-to-install)
  * [Advanced configuration](#advanced-configuration)

<!-- vim-markdown-toc -->

## Module description

[Taiga](https://taiga.io/) is a project management platform.
This Puppet module simplifies the installation and configuration of Taiga in your infrastructure.

## Usage

### Installing a basic HTTP Taiga instance

In order to install `taiga-back`, `taiga-front` and an apache virtual host, the following is enough:

```puppet
class { 'taiga':
  hostname         => 'taiga.io',
  protocol         => 'http',
  back_secret_key  => 'secret',
  back_db_password => 'secret',  # currently unused
}
```

### Installing a secured HTTPS Taiga instance

```puppet
class { 'taiga':
  hostname         => 'taiga.io',
  back_secret_key  => 'secret',
  back_db_password => 'secret',  # currently unused
  ssl_key          => '/path/to/key.pem',
  ssl_cert         => '/path/to/certificate.pem',
  ssl_chain        => '/path/to/ca/chain.pem',
}
```

### Choosing which version to install

By default, the module will install the latest stable release and will not auto-update it.  If you prefer to install a given release, you can do the following:

```puppet
class { 'taiga':
  # [...]
  repo_revision => '2.1.0',
}
```

If you want to track the stable branch and install update as the stable branch is updated:

```puppet
class { 'taiga':
  # [...]
  repo_ensure   => 'latest',
  repo_revision => 'stable',
}
```

If you like the danger:

```puppet
class { 'taiga':
  # [...]
  repo_ensure   => 'latest',
  repo_revision => 'main',
}
```

### Advanced configuration

Instead of using the `taiga` class, rely on the `taiga::front` and `taiga::back` classes.  This allows you to have a full controll on both the front and the back, and run for example the back on a node, and servce the front from another.
