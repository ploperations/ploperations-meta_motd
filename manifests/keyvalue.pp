# @summary Add a line to the "key: value" section of the MOTD
#
# Add a line to the "key: value" section of the MOTD.
# All such values go between the header and entries added via meta_motd::register.
# Services added by the profile_metadata module will also be below these entries.
#
# @param Pattern[/^\w([\s\w-]*\w)?:\s/] content
#   A string in "key: value" format. The key must start with a word character (regex `\w`).
#   It can then have zero or more spaces, word characters, or dashes.
#   Next it must contain another word character followed by a colon and a space.
#
# @example
#   meta_motd::keyvalue { "PE build: ${facts['pe_build']}": }
#
# @example
#   meta_motd::keyvalue { "Jenkins alias: ${url}": }
#
define meta_motd::keyvalue (
  Pattern[/^\w([\s\w-]*\w)?:\s/] $content = $title,
) {

  meta_motd::fragment { "keyvalue: ${title}":
    content => "${content}\n",
    order   => '10',
  }

  include meta_motd::keyvalue::blank
}
