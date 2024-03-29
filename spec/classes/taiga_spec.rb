# frozen_string_literal: true

require 'spec_helper'

describe 'taiga' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:pre_condition) do
        <<~PP
          class { 'python':
            dev => present,
          }
        PP
      end
      let(:facts) { facts.merge({ 'python3_version' => '3.8.0' }) }
      let(:params) do
        {
          hostname: 'example.com',
          back_secret_key: 'Use a really secret string here',
          back_db_password: 'unused',
        }
      end

      it { is_expected.to compile.with_all_deps }
    end
  end
end
