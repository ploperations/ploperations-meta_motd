# Adds blank link after the "key: value" entries in the MOTD
class meta_motd::keyvalue::blank {
  meta_motd::fragment { $title:
    order   => '11',
    content => "\n",
  }
}
