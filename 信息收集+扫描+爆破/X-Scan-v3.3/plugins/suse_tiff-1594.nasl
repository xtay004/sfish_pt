
#
# (C) Tenable Network Security
#
# The text description of this plugin is (C) Novell, Inc.
#

include("compat.inc");

if ( ! defined_func("bn_random") ) exit(0);

if(description)
{
 script_id(27468);
 script_version ("$Revision: 1.5 $");
 script_name(english: "SuSE Security Update:  Tiff security update (tiff-1594)");
 script_set_attribute(attribute: "synopsis", value: 
"The remote SuSE system is missing the security patch tiff-1594");
 script_set_attribute(attribute: "description", value: "This update fixes a stack-based buffer overflow in 
tiffsplit that can be triggered with long filemanes 
(CVE-2006-2656) and a buffer overflow in tiff2pdf. Both 
tools are not setuid but may be exploited in conjunction 
with other applications. Exploitation very unlikely.
");
 script_set_attribute(attribute: "cvss_vector", value: "CVSS2#AV:N/AC:L/Au:N/C:P/I:P/A:P");
script_set_attribute(attribute: "solution", value: "Install the security patch tiff-1594");
script_end_attributes();

script_cve_id("CVE-2006-2656");
script_summary(english: "Check for the tiff-1594 package");
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security");
 script_family(english: "SuSE Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/SuSE/rpm-list");
 exit(0);
}

include("rpm.inc");

if ( ! get_kb_item("Host/SuSE/rpm-list") ) exit(1, "Could not gather the list of packages");
if ( rpm_check( reference:"tiff-3.8.2-5.6", release:"SUSE10.1") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
exit(0,"Host is not affected");
