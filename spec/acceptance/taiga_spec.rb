require 'spec_helper_acceptance'

describe 'taiga class' do
  it 'works idempotently with no errors' do
    options[:forge_host] = 'https://forge.puppet.com'
    puppet_module_install(module_name: 'puppetlabs-apache')

    pp = <<~MANIFEST
      file { '/srv/www':
        ensure => directory,
      }

      package { 'git':
        ensure => installed,
      }

      class { 'taiga':
        hostname         => 'taiga.io',
        protocol         => 'http',
        back_secret_key  => 'secret',
        back_db_password => 'secret',
      }
    MANIFEST

    apply_manifest(pp, catch_failures: true)
    apply_manifest(pp, catch_changes: true)
  end
end
