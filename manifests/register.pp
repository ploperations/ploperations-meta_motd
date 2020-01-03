# @summary Deprecated: add an old-style entry to the MOTD.
#
# Generally you should rely on profile_metadata::service instead of doing
# thins like `meta_motd::register {'profile::foo': }`
# If you are not using the profile_metadata module or have other needs,
# you can use `meta_motd::fragment` or `meta_motd::keyvalue.
#
# @api private
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
