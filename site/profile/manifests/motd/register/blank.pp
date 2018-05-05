# Adds blank link after the profile::motd::register entries
class profile::motd::register::blank {
  profile::motd::fragment { $title:
    order   => '30',
    content => "\n",
  }
}
