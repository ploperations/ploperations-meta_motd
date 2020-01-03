# @summary Add a fragment to the MOTD, if allowed
#
# Add a fragment to the MOTD, if allowed
#
# @param [String[1]] content
#   the content to add to the MOTD
#
# @param [String[2]] order
#   the order option to be passed to the concat::fragment
#
# @example
#   meta_motd::fragment { 'EoL Notice':
#     content => @(END),
#       NOTICE: this system is scheduled for decommissioning within the next two weeks
#       Contact IT if this poses a problem for you or your team.
#       | END
#   }
#
define meta_motd::fragment (
  String[1] $content = $title,
  String[2] $order   = '50',
) {
  if $facts['os']['family'] != 'windows' {
    include meta_motd

    if ! $meta_motd::suppress {
      concat::fragment { "/etc/motd ${title}":
        target  => '/etc/motd',
        content => $content,
        order   => $order,
      }
    }
  }
}
