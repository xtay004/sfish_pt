# This script was automatically generated from the dsa-895
# Debian Security Advisory
# It is released under the Nessus Script Licence.
# Advisory is copyright 1997-2009 Software in the Public Interest, Inc.
# See http://www.debian.org/license
# DSA2nasl Convertor is copyright 2004-2009 Tenable Network Security, Inc.

if (! defined_func('bn_random')) exit(0);

include('compat.inc');

if (description) {
 script_id(22761);
 script_version("$Revision: 1.6 $");
 script_xref(name: "DSA", value: "895");
 script_cve_id("CVE-2005-3149");

 script_set_attribute(attribute:'synopsis', value: 
'The remote host is missing the DSA-895 security update');
 script_set_attribute(attribute: 'description', value:
'Masanari Yamamoto discovered incorrect use of environment variables in
uim, a flexible input method collection and library, that could lead
to escalated privileges in setuid/setgid applications linked to
libuim.  Affected in Debian is at least mlterm.
The old stable distribution (woody) does not contain uim packages.
For the stable distribution (sarge) this problem has been fixed in
version 0.4.6final1-3sarge1.
');
 script_set_attribute(attribute: 'see_also', value: 
'http://www.debian.org/security/2005/dsa-895');
 script_set_attribute(attribute: 'solution', value: 
'The Debian project recommends that you upgrade your libuim packages.');
script_set_attribute(attribute: 'cvss_vector', value: 'CVSS2#AV:L/AC:L/Au:N/C:P/I:P/A:P');
script_end_attributes();

 script_copyright(english: "This script is (C) 2009 Tenable Network Security, Inc.");
 script_name(english: "[DSA895] DSA-895-1 uim");
 script_category(ACT_GATHER_INFO);
 script_family(english: "Debian Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/Debian/dpkg-l");
 script_summary(english: "DSA-895-1 uim");
 exit(0);
}

include("debian_package.inc");

if ( ! get_kb_item("Host/Debian/dpkg-l") ) exit(1, "Could not obtain the list of packages");

deb_check(prefix: 'libuim-dev', release: '3.1', reference: '0.4.6final1-3sarge1');
deb_check(prefix: 'libuim-nox-dev', release: '3.1', reference: '0.4.6final1-3sarge1');
deb_check(prefix: 'libuim0', release: '3.1', reference: '0.4.6final1-3sarge1');
deb_check(prefix: 'libuim0-dbg', release: '3.1', reference: '0.4.6final1-3sarge1');
deb_check(prefix: 'libuim0-nox', release: '3.1', reference: '0.4.6final1-3sarge1');
deb_check(prefix: 'libuim0-nox-dbg', release: '3.1', reference: '0.4.6final1-3sarge1');
deb_check(prefix: 'uim', release: '3.1', reference: '0.4.6final1-3sarge1');
deb_check(prefix: 'uim-anthy', release: '3.1', reference: '0.4.6final1-3sarge1');
deb_check(prefix: 'uim-applet-gnome', release: '3.1', reference: '0.4.6final1-3sarge1');
deb_check(prefix: 'uim-canna', release: '3.1', reference: '0.4.6final1-3sarge1');
deb_check(prefix: 'uim-common', release: '3.1', reference: '0.4.6final1-3sarge1');
deb_check(prefix: 'uim-fep', release: '3.1', reference: '0.4.6final1-3sarge1');
deb_check(prefix: 'uim-gtk2.0', release: '3.1', reference: '0.4.6final1-3sarge1');
deb_check(prefix: 'uim-m17nlib', release: '3.1', reference: '0.4.6final1-3sarge1');
deb_check(prefix: 'uim-prime', release: '3.1', reference: '0.4.6final1-3sarge1');
deb_check(prefix: 'uim-skk', release: '3.1', reference: '0.4.6final1-3sarge1');
deb_check(prefix: 'uim-utils', release: '3.1', reference: '0.4.6final1-3sarge1');
deb_check(prefix: 'uim-xim', release: '3.1', reference: '0.4.6final1-3sarge1');
if (deb_report_get()) security_warning(port: 0, extra:deb_report_get());
else exit(0, "Host is not affected");
