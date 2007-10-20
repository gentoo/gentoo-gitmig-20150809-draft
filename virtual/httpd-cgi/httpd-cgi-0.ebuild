# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/httpd-cgi/httpd-cgi-0.ebuild,v 1.1 2007/10/20 14:43:57 wrobel Exp $

DESCRIPTION="Virtual for CGI-enabled webservers"
HOMEPAGE="http://gentoo.org/"
SRC_URI=""

LICENSE="as-is"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 s390 sh sparc ~sparc-fbsd x86 ~x86-fbsd"
IUSE=""

RDEPEND="|| (
	www-servers/apache
	www-servers/lighttpd
	www-servers/boa
	www-servers/bozohttpd
	www-servers/cherokee
	www-servers/fnord
	www-servers/jetty
	www-servers/mini_httpd
	www-servers/monkeyd
	www-servers/nginx
	www-servers/orion
	www-servers/resin
	www-servers/shttpd
	www-servers/skunkweb
	www-servers/thttpd
	www-servers/tomcat
	www-servers/tux
	www-servers/yaws
	)"
DEPEND=""
