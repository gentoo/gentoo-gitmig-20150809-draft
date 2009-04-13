# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/httpd-fastcgi/httpd-fastcgi-0.ebuild,v 1.2 2009/04/13 08:30:43 hollow Exp $

DESCRIPTION="Virtual for FastCGI-enabled webservers"
HOMEPAGE="http://gentoo.org/"
SRC_URI=""

LICENSE="as-is"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 s390 sh sparc ~sparc-fbsd x86 ~x86-fbsd"
IUSE=""

RDEPEND="|| (
	www-servers/apache
	www-servers/lighttpd
	www-servers/bozohttpd
	www-servers/nginx
	www-servers/resin
	www-servers/skunkweb
	www-servers/cherokee
	)"
DEPEND=""
