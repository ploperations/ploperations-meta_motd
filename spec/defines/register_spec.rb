require 'spec_helper'

describe 'meta_motd::register' do
  let(:title) { 'special server group' }
  let(:params) do
    {}
  end

  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      it { is_expected.to compile }
    end
  end
end
