require 'spec_helper'

describe 'meta_motd' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      context 'with default params' do
        let(:facts) { os_facts }

        it { is_expected.to compile }
      end

      context 'with colossal-puppet-dag template' do
        let(:facts) { os_facts }

        context 'without a location' do
          let(:params) do
            {
              'epp_template' => 'meta_motd/colossal-puppet-dag.epp',
              'epp_params' => {
                'roles' => ['role::test_box'],
              },
            }
          end

          it { is_expected.to compile }
        end

        context 'with a location' do
          let(:params) do
            {
              'epp_template' => 'meta_motd/colossal-puppet-dag.epp',
              'epp_params' => {
                'roles' => ['role::test_box'],
                'location' => 'test environment',
              },
            }
          end

          it { is_expected.to compile }
          it { is_expected.to contain_concat__fragment('motd_header').with_content(%r{-\stest\senvironment$}) }
        end
      end

      context 'with tall-puppet template' do
        let(:facts) do
          os_facts.merge(
            :profile_metadata['services'] => [
              'service1' => {
                'owner_uid' => 'john.doe',
                'team' => 'infracore',
                'end_users' => [
                  'group1@example.com',
                  'group2@example.com',
                ],
                'escalation_period' => 'pdx-workhours',
                'downtime_impact' => 'Development work will be blocked because their changes cannot be tested and thus cannot be merged.',
                'notes' => 'This is just a test :)',
                'doc_urls' => ['https://www.example.com/page1'],
                'human_name' => 'Internal InfraCore CI',
                'other_fqdns' => ['alt.example.com'],
              },
            ],
          )
        end

        let(:params) do
          {
            'epp_template' => 'meta_motd/tall-puppet.epp',
            'epp_params' => {
              'roles' => ['role::test_box'],
              'location' => 'test environment',
            },
          }
        end

        it { is_expected.to compile }

        case os_facts[:os]['family']
        when 'Debian'
          # The line listing the operating system should look like one of these on Debian:
          # "OS: Debian 10 aka buster"
          # "OS: Ubuntu 18.04 aka bionic"
          it { is_expected.to contain_concat__fragment('motd_header').with_content(%r{OS:\s[\w\s]+\d+((\.\d+)+)?\s[\w\s]+$}) }
        else
          # The line listing the operating system should look like one of these on everything else:
          # "OS: CentOS 7"
          # "OS: Solaris 11"
          it { is_expected.to contain_concat__fragment('motd_header').with_content(%r{OS:\s[\w\s]+\d+$}) }
        end
      end
    end
  end
end
