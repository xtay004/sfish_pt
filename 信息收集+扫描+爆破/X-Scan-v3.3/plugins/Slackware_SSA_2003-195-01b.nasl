# This script was automatically generated from the SSA-2003-195-01b
# Slackware Security Advisory
# It is released under the Nessus Script Licence.
# Slackware Security Advisories are copyright 1999-2009 Slackware Linux, Inc.
# SSA2nasl Convertor is copyright 2004-2009 Tenable Network Security, Inc.
# See http://www.slackware.com/about/ or http://www.slackware.com/security/
# Slackware(R) is a registered trademark of Slackware Linux, Inc.

if (! defined_func("bn_random")) exit(0);
include('compat.inc');

if (description) {
script_id(18724);
script_version("$Revision: 1.4 $");
script_category(ACT_GATHER_INFO);
script_family(english: "Slackware Local Security Checks");
script_dependencies("ssh_get_info.nasl");
script_copyright("This script is Copyright (C) 2009 Tenable Network Security, Inc.");
script_require_keys("Host/Slackware/release", "Host/Slackware/packages");

script_set_attribute(attribute:'synopsis', value:
'The remote host is missing the SSA-2003-195-01b security update');
script_set_attribute(attribute:'description', value: '
New nfs-utils packages are available for Slackware 8.1, 9.0, and -current
to replace the ones that were issued yesterday.  A bug in has been fixed
in utils/mountd/auth.c that could cause mountd to crash.

');
script_set_attribute(attribute:'solution', value: 
'Update the packages that are referenced in the security advisory.');
script_xref(name: "SSA", value: "2003-195-01b");
script_summary("SSA-2003-195-01b nfs-utils packages replaced ");
script_name(english: "SSA-2003-195-01b nfs-utils packages replaced ");
script_set_attribute(attribute: 'risk_factor', value: 'High');
script_end_attributes();
exit(0);
}

include('slackware.inc');
include('global_settings.inc');

if ( ! get_kb_item('Host/Slackware/packages') ) exit(1, 'Could not obtain the list of packages');

extrarep = NULL;
if (slackware_check(osver: "8.1", pkgname: "nfs-utils", pkgver: "1.0.4", pkgnum:  "2", pkgarch: "i386")) {
w++;
if (report_verbosity > 0) extrarep = strcat(extrarep, '
The package nfs-utils is vulnerable in Slackware 8.1
Upgrade to nfs-utils-1.0.4-i386-2 or newer.
');
}
if (slackware_check(osver: "9.0", pkgname: "nfs-utils", pkgver: "1.0.4", pkgnum:  "2", pkgarch: "i386")) {
w++;
if (report_verbosity > 0) extrarep = strcat(extrarep, '
The package nfs-utils is vulnerable in Slackware 9.0
Upgrade to nfs-utils-1.0.4-i386-2 or newer.
');
}
if (slackware_check(osver: "-current", pkgname: "nfs-utils", pkgver: "1.0.4", pkgnum:  "2", pkgarch: "i486")) {
w++;
if (report_verbosity > 0) extrarep = strcat(extrarep, '
The package nfs-utils is vulnerable in Slackware -current
Upgrade to nfs-utils-1.0.4-i486-2 or newer.
');
}

if (w) { security_hole(port: 0, extra: extrarep); }

else exit(0, "Host is not affected");
