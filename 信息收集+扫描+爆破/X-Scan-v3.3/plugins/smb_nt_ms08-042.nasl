#
# (C) Tenable Network Security, Inc.
#


include("compat.inc");

if(description)
{
 script_id(33871);
 script_version("$Revision: 1.5 $");

 script_cve_id("CVE-2008-2244");
 script_bugtraq_id(30124);
 script_xref(name:"OSVDB", value:"46914");

 name["english"] = "MS08-042: Vulnerabilities in Microsoft Word Could Allow Remote Code Execution (955048)";

 script_name(english:name["english"]);
 
 script_set_attribute(attribute:"synopsis", value:
"Arbitrary code can be executed on the remote host through Microsoft
Word." );
 script_set_attribute(attribute:"description", value:
"The remote host is running a version of Microsoft Word which is
subject to a flaw which may allow arbitrary code to be run. 

An attacker may use this to execute arbitrary code on this host. 

To succeed, the attacker would have to send a rogue file to a user of
the remote computer and have it open it.  Then a bug in the word
record parsing handler would result in code execution." );
 script_set_attribute(attribute:"solution", value:
"Microsoft has released a set of patches for Word XP and 2003 :

http://www.microsoft.com/technet/security/bulletin/ms08-042.mspx" );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:M/Au:N/C:C/I:C/A:C" );


script_end_attributes();

 
 summary["english"] = "Determines the version of WinWord.exe";

 script_summary(english:summary["english"]);
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2008-2009 Tenable Network Security, Inc.");
 family["english"] = "Windows : Microsoft Bulletins";
 script_family(english:family["english"]);
 
 script_dependencies("smb_nt_ms02-031.nasl");
 exit(0);
}

include("smb_hotfixes_fcheck.inc");

port = get_kb_item("SMB/transport");


#
# Word
#
v = get_kb_item("SMB/Office/Word/Version");
if ( v ) 
{
 if(ereg(pattern:"^10\..*", string:v))
 {
  # Word XP - fixed in 10.0.6846.0
   middle =  ereg_replace(pattern:"^10\.0\.([0-9]*)\.[0-9]*$", string:v, replace:"\1");
  if(middle != v && int(middle) < 6846) { {
 set_kb_item(name:"SMB/Missing/MS08-042", value:TRUE);
 hotfix_security_hole();
 }}
 }
 else if(ereg(pattern:"^11\..*", string:v))
 {
  # Word 2003 - fixed in 11.0.8227.0 (SP3)
   middle =  ereg_replace(pattern:"^11\.0\.([0-9]*)\.[0-9]*$", string:v, replace:"\1");
  if(middle != v && int(middle) < 8227) { {
 set_kb_item(name:"SMB/Missing/MS08-042", value:TRUE);
 hotfix_security_hole();
 }}
 }
}

