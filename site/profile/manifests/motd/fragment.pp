# Add a fragment to the MOTD, if allowed
define profile::motd::fragment (
  String[1] $content = $title,
  String[2] $order   = '50',
) {
  if $facts['os']['family'] != 'windows' {
    include profile::motd

    if ! $profile::motd::suppress {
      concat::fragment { "/etc/motd ${title}":
        target  => '/etc/motd',
        content => $content,
        order   => $order,
      }
    }
  }
}
