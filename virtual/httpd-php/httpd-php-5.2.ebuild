# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/httpd-php/httpd-php-5.2.ebuild,v 1.4 2010/09/21 19:28:41 grobian Exp $

EAPI="2"

DESCRIPTION="Virtual to provide PHP-enabled webservers"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="5.2"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 s390 sh sparc x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~ia64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos"
IUSE=""

RDEPEND="|| ( =dev-lang/php-5.2*[apache2]
			  =dev-lang/php-5.2*[cgi] )"
DEPEND=""
