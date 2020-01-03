require 'spec_helper'

describe 'meta_motd::keyvalue' do
  let(:title) { 'extra-data' }
  let(:params) do
    { 'content' => 'This key: has a value :)' }
  end

  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      it { is_expected.to compile }
    end
  end
end
