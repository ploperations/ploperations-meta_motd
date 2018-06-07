# Update /etc/motd with information about the host
#
# It is sometimes useful to disable changes to /etc/motd when comparing runs in
# different environments. To do that:
#
#   sudo FACTER_suppress_motd=true puppet agent --test ...
class profile::motd {
  case $facts['suppress_motd'] {
    true, 'true':          { $suppress = true }
    undef, false, 'false': { $suppress = false }
    default: {
      fail("Invalid value for fact suppress_motd: ${facts['suppress_motd']}")
    }
  }

  if ! $suppress {
    concat { '/etc/motd':
      owner => 'root',
      group => 'root',
      mode  => '0644',
    }

    concat::fragment { 'motd_header':
      target  => '/etc/motd',
      order   => '05',
      content => epp('profile/motd.epp', {
        roles => lookup('classes', Array[String], 'unique', []),
      }),
    }

    if $facts['fqdn'] != $trusted['certname'] {
      profile::motd::keyvalue { "Certname: ${trusted['certname']}": }
    }

    if $facts['pe_build'] {
      profile::motd::keyvalue { "PE build: ${facts['pe_build']}": }
    }
  }

  # 2016-08: Remove /etc/banner
  file { '/etc/banner':
    ensure => absent,
  }
}
