# Add a fragment to the MOTD, if allowed
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
