# Update /etc/motd with information about the host
#
# It is sometimes useful to disable changes to /etc/motd when comparing runs in
# different environments. To do that:
#
#   sudo FACTER_suppress_motd=true puppet agent --test ...
class meta_motd (
  Array[String[1]] $roles = lookup('classes', Array[String], 'unique', []),
  Optional[String[1]] $location = undef,
) {
  # lint:ignore:quoted_booleans
  case $facts['suppress_motd'] {
    true, 'true':          { $suppress = true }
    undef, false, 'false': { $suppress = false }
    default: {
      fail("Invalid value for fact suppress_motd: ${facts['suppress_motd']}")
    }
  }
  # lint:endignore

  $motd_group = $facts['kernel'] ? {
    'Darwin' => 'wheel',
    default  => 'root',
  }

  if ! $suppress {
    concat { '/etc/motd':
      owner => 'root',
      group => $motd_group,
      mode  => '0644',
    }

    concat::fragment { 'motd_header':
      target  => '/etc/motd',
      order   => '05',
      content => epp('meta_motd/motd.epp', {
        roles => lookup('classes', Array[String], 'unique', []),
      }),
    }

    if $facts['networking']['fqdn'] != $trusted['certname'] {
      meta_motd::keyvalue { "Certname: ${trusted['certname']}": }
    }

    if $facts['pe_build'] {
      meta_motd::keyvalue { "PE build: ${facts['pe_build']}": }
    }
  }
}
