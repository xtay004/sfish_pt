# This script was automatically generated from 
#  http://www.gentoo.org/security/en/glsa/glsa-200612-07.xml
# It is released under the Nessus Script Licence.
# The messages are release under the Creative Commons - Attribution /
# Share Alike license. See http://creativecommons.org/licenses/by-sa/2.0/
#
# Avisory is copyright 2001-2006 Gentoo Foundation, Inc.
# GLSA2nasl Convertor is copyright 2004-2009 Tenable Network Security, Inc.

if (! defined_func('bn_random')) exit(0);

include('compat.inc');

if (description)
{
 script_id(23859);
 script_version("$Revision: 1.5 $");
 script_xref(name: "GLSA", value: "200612-07");
 script_cve_id("CVE-2006-5462", "CVE-2006-5463", "CVE-2006-5464", "CVE-2006-5747", "CVE-2006-5748");

 script_set_attribute(attribute:'synopsis', value: 'The remote host is missing the GLSA-200612-07 security update.');
 script_set_attribute(attribute:'description', value: 'The remote host is affected by the vulnerability described in GLSA-200612-07
(Mozilla Firefox: Multiple vulnerabilities)


    Mozilla Firefox improperly handles Script objects while they are being
    executed. Mozilla Firefox has also been found to be vulnerable to
    various possible buffer overflows. Lastly, the binary release of
    Mozilla Firefox is vulnerable to a low exponent RSA signature forgery
    issue because it is bundled with a vulnerable version of NSS.
  
Impact

    An attacker could entice a user to view specially crafted JavaScript
    and execute arbitrary code with the rights of the user running Mozilla
    Firefox. An attacker could also entice a user to view a specially
    crafted web page that causes a buffer overflow and again executes
    arbitrary code. It is also possible for an attacker to make up SSL/TLS
    certificates that would not be detected as invalid by the binary
    release of Mozilla Firefox, raising the possibility for
    Man-in-the-Middle attacks.
  
Workaround

    There is no known workaround at this time.
  
');
script_set_attribute(attribute:'solution', value: '
    All Mozilla Firefox users should upgrade to the latest version:
    # emerge --sync
    # emerge --ask --oneshot --verbose ">=www-client/mozilla-firefox-1.5.0.8"
    All Mozilla Firefox binary release users should upgrade to the latest
    version:
    # emerge --sync
    # emerge --ask --oneshot --verbose ">=www-client/mozilla-firefox-bin-1.5.0.8"
  ');
script_set_attribute(attribute: 'cvss_vector', value: 'CVSS2#AV:N/AC:L/Au:N/C:P/I:P/A:P');
script_set_attribute(attribute: 'see_also', value: 'http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2006-5462');
script_set_attribute(attribute: 'see_also', value: 'http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2006-5463');
script_set_attribute(attribute: 'see_also', value: 'http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2006-5464');
script_set_attribute(attribute: 'see_also', value: 'http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2006-5747');
script_set_attribute(attribute: 'see_also', value: 'http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2006-5748');

script_set_attribute(attribute: 'see_also', value: 'http://www.gentoo.org/security/en/glsa/glsa-200612-07.xml');

script_end_attributes();

 script_copyright(english: "(C) 2009 Tenable Network Security, Inc.");
 script_name(english: '[GLSA-200612-07] Mozilla Firefox: Multiple vulnerabilities');
 script_category(ACT_GATHER_INFO);
 script_family(english: "Gentoo Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys('Host/Gentoo/qpkg-list');
 script_summary(english: 'Mozilla Firefox: Multiple vulnerabilities');
 exit(0);
}

include('qpkg.inc');

if ( ! get_kb_item('Host/Gentoo/qpkg-list') ) exit(1, 'No list of packages');
if (qpkg_check(package: "www-client/mozilla-firefox-bin", unaffected: make_list("ge 1.5.0.8"), vulnerable: make_list("lt 1.5.0.8")
)) { security_hole(0); exit(0); }
if (qpkg_check(package: "www-client/mozilla-firefox", unaffected: make_list("ge 1.5.0.8"), vulnerable: make_list("lt 1.5.0.8")
)) { security_hole(0); exit(0); }
exit(0, "Host is not affected");
