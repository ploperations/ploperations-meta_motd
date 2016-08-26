# Add a message to the MOTD
define profile::motd::register (
  String[1] $content = $title,
  Integer $order = 20,
) {
  include ::profile::motd

  if ! $::profile::motd::suppress {
    concat::fragment { "motd_fragment_${name}":
      target  => '/etc/motd',
      content => "    -- ${body}\n",
      order   => $order,
    }
  }
}
