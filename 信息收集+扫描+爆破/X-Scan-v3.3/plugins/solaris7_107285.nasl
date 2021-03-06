#
# (C) Tenable Network Security
#
#

if ( ! defined_func("bn_random") ) exit(0);
include("compat.inc");

if(description)
{
 script_id(13106);
 script_version("$Revision: 1.12 $");

 script_name(english: "Solaris 7 (sparc) : 107285-09");
 script_set_attribute(attribute: "synopsis", value:
"The remote host is missing Sun Security Patch number 107285-09");
 script_set_attribute(attribute: "description", value:
'SunOS 5.7: passwd & pam Library Patch.
Date this patch was last updated by Sun : Nov/26/02');
 script_set_attribute(attribute: "solution", value:
"You should install this patch for your system to be up-to-date.");
 script_set_attribute(attribute: "see_also", value:
"http://sunsolve.sun.com/search/document.do?assetkey=1-21-107285-09-1");
 script_set_attribute(attribute: "risk_factor", value: "Medium");
 script_end_attributes();

 script_summary(english: "Check for patch 107285-09");
 script_category(ACT_GATHER_INFO);
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security");
 family["english"] = "Solaris Local Security Checks";
 script_family(english:family["english"]);
 
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/Solaris/showrev");
 exit(0);
}



include("solaris.inc");

e +=  solaris_check_patch(release:"5.7", arch:"sparc", patch:"107285-09", obsoleted_by:"", package:"SUNWcsl", version:"11.7.0,REV=1998.09.01.04.16");
e +=  solaris_check_patch(release:"5.7", arch:"sparc", patch:"107285-09", obsoleted_by:"", package:"SUNWcslx", version:"11.7.0,REV=1998.09.01.04.16");
e +=  solaris_check_patch(release:"5.7", arch:"sparc", patch:"107285-09", obsoleted_by:"", package:"SUNWcsu", version:"11.7.0,REV=1998.10.06.00.59");
e +=  solaris_check_patch(release:"5.7", arch:"sparc", patch:"107285-09", obsoleted_by:"", package:"SUNWhea", version:"11.7.0,REV=1998.09.01.04.16");
e +=  solaris_check_patch(release:"5.7", arch:"sparc", patch:"107285-09", obsoleted_by:"", package:"SUNWnisu", version:"11.7.0,REV=1998.09.01.04.16");
if ( e < 0 ) { 
	if ( NASL_LEVEL < 3000 ) 
	   security_warning(0);
	else  
	   security_warning(port:0, extra:solaris_get_report());
	exit(0); 
} 
exit(0, "Host is not affected");
