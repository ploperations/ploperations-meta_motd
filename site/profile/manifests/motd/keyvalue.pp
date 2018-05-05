# Add a line to the "key: value" section of the MOTD
#
# All such values go between the header and the services.
define profile::motd::keyvalue (
  String[1] $content = $title,
) {
  include profile::motd::keyvalue::blank
  profile::motd::fragment { "keyvalue: ${title}":
    content => "${content}\n",
    order   => '10',
  }
}
