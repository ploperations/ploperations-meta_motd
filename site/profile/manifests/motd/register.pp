# Deprecated: add an old-style to the MOTD.
#
# Generally you should rely on profile::metadata::service, but if you need to
# add something else, use profile::motd::fragment instead of this.
define profile::motd::register (
  String[1] $content = $title,
  String[2] $order = '20',
) {
  include profile::motd::register::blank
  profile::motd::fragment { $title:
    content => "${content}\n",
    order   => $order,
  }
}
