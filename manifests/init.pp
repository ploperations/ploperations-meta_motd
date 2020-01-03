# @summary Update /etc/motd with information about the host
#
# Update /etc/motd with information about the host.
#
# - If the system is a Puppet Enterprise server an entry will automatically be added
#   to the MOTD showing what version of PE is installed.
# - Similarly, an entry will be added showing what the certname used by the system 
#   is if the FQDN and the certname do not match.
#
# Note: It is sometimes useful to disable changes to /etc/motd when comparing runs in
# different environments. You can do that like so:
# `sudo FACTER_suppress_motd=true puppet agent --test ...`
#
# @param [String[1]] epp_template
#   This is the path to an EPP template passed into content parameter
#   of a concat::fragment resource. All templates in this module are avaialable
#   by setting this to `meta_motd/<name of template file>`. This can also be
#   set to use an EPP templates from another module by replacing the `meta_motd`
#   part of the path.
#
# @param [Hash] epp_params
#   This represents the parameters that will be passed to the template
#   referenced in `$epp_template`. If you have defined a template that does
#   not need parameters you can set this to `{}`.
#
# @example Set MOTD template based on a conditional expression
#   class profile::motd {
#     case $profile::server::someparam {
#       /infranext/: { $motd_template = 'meta_motd/colossal-puppet-dag.epp' }
#       default:     { $motd_template = 'meta_motd/short-puppet.epp' }
#     }
#
#     class { 'meta_motd':
#       epp_template => $motd_template,
#       epp_params   => {
#         roles    => lookup('classes', Array[String], 'unique', []),
#         location => $facts['whereami'],
#       },
#     }
#   }
#
# @example Use a template stored in your profile module
#   class { 'meta_motd':
#     epp_template => 'profile/motd.epp',
#   }
#
class meta_motd (
  String[1] $epp_template = 'meta_motd/short-puppet.epp',
  Hash $epp_params = {
    roles    => lookup('classes', Array[String], 'unique', []),
    location => undef,
  },
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
      content => epp($epp_template, $epp_params),
    }

    if $facts['networking']['fqdn'] != $trusted['certname'] {
      meta_motd::keyvalue { "Certname: ${trusted['certname']}": }
    }

    if $facts['pe_build'] {
      meta_motd::keyvalue { "PE build: ${facts['pe_build']}": }
    }
  }
}
