# Adds blank link after the "key: value" entries in the MOTD
class profile::motd::keyvalue::blank {
  profile::motd::fragment { $title:
    order   => '11',
    content => "\n",
  }
}
