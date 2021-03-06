
#
# (C) Tenable Network Security
#
# The text description of this plugin is (C) Novell, Inc.
#

include("compat.inc");

if ( ! defined_func("bn_random") ) exit(0);

if(description)
{
 script_id(29789);
 script_version ("$Revision: 1.3 $");
 script_name(english: "SuSE Security Update:  rsync: fix to deny bypassing of module hierarchy (rsync-4793)");
 script_set_attribute(attribute: "synopsis", value: 
"The remote SuSE system is missing the security patch rsync-4793");
 script_set_attribute(attribute: "description", value: "This update fixes a bug in rsync that allowed remote
attackers to access restricted files outside a module's
hierarchy if no chroot setup was used. (CVE-2007-6199)
Please read http://rsync.samba.org/security.html entry from
November 28th, 2007 to get more information about a secure
configuration of rsync that also covers the bug tracked
with CVE-2007-6200.  This update also fixes some crashes
that only affect rsync-2.6.8 on SLES10.
");
 script_set_attribute(attribute: "cvss_vector", value: "CVSS2#AV:N/AC:L/Au:N/C:C/I:C/A:C");
script_set_attribute(attribute: "solution", value: "Install the security patch rsync-4793");
script_end_attributes();

script_cve_id("CVE-2007-6199", "CVE-2007-6200");
script_summary(english: "Check for the rsync-4793 package");
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security");
 script_family(english: "SuSE Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/SuSE/rpm-list");
 exit(0);
}

include("rpm.inc");

if ( ! get_kb_item("Host/SuSE/rpm-list") ) exit(1, "Could not gather the list of packages");
if ( rpm_check( reference:"rsync-2.6.9-55.4", release:"SUSE10.3") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
exit(0,"Host is not affected");
