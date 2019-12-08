# Deprecated: add an old-style to the MOTD.
#
# Generally you should rely on profile_metadata::service, but if you need to
# add something else, use meta_motd::fragment instead of this.
define meta_motd::register (
  String[1] $content = $title,
  String[2] $order = '20',
) {
  include meta_motd::register::blank

  meta_motd::fragment { $title:
    content => "${content}\n",
    order   => $order,
  }
}
