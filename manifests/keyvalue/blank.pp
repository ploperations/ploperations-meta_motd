# @summary Adds blank link after the `meta_motd::keyvalue` entries
#
# Adds blank link after the `meta_motd::keyvalue` entries
#
# @api private
class meta_motd::keyvalue::blank {
  meta_motd::fragment { $title:
    order   => '11',
    content => "\n",
  }
}
