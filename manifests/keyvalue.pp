# Add a line to the "key: value" section of the MOTD
#
# All such values go between the header and the services.
define meta_motd::keyvalue (
  String[1] $content = $title,
) {
  include meta_motd::keyvalue::blank
  meta_motd::fragment { "keyvalue: ${title}":
    content => "${content}\n",
    order   => '10',
  }
}