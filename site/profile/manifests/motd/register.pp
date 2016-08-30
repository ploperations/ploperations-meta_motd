# Add a message to the MOTD
define profile::motd::register (
  String[1] $content = $title,
  String[2] $order = '20',
) {
  include ::profile::motd

  if ! $::profile::motd::suppress {
    concat::fragment { "motd_fragment_${title}":
      target  => '/etc/motd',
      content => "    -- ${content}\n",
      order   => $order,
    }
  }
}
