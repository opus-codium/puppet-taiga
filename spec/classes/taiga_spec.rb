require 'spec_helper'

describe 'taiga' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) { facts }
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
