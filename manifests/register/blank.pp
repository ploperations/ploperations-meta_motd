# @summary Adds blank link after the `meta_motd::register` entries
#
# Adds blank link after the `meta_motd::register` entries
#
# @api private
class meta_motd::register::blank {
  meta_motd::fragment { $title:
    order   => '30',
    content => "\n",
  }
}
