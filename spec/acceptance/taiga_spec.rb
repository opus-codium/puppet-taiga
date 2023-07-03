# frozen_string_literal: true

require 'spec_helper_acceptance'

describe 'taiga class' do
  it 'works idempotently with no errors' do
    options[:forge_host] = 'https://forge.puppet.com'
    shell('puppet module install puppetlabs-apache')

    pp = <<~MANIFEST
      file { '/srv/www':
        ensure => directory,
      }

      package { 'git':
        ensure => installed,
      }

      class { 'python':
        dev  => 'present',
        venv => 'present',
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
