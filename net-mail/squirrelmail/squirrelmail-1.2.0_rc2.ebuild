# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Grant Goodyear <g2boojum@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-mail/squirrelmail/squirrelmail-1.2.0_rc2.ebuild,v 1.1 2001/10/17 18:33:43 g2boojum Exp $

S=${WORKDIR}/${PN}-1.2.0-rc2
HTTPD_ROOT="/usr/local/httpd/htdocs"

DESCRIPTION="Webmail for nuts!"

SRC_URI="http://prdownloads.sf.net/${PN}/${PN}-1.2.0-rc2.tar.gz"
HOMEPAGE="http://www.squirrelmail.org"

DEPEND="dev-lang/php
        net-www/apache"

#Really should be virtual/imap!!!
RDEPEND="net-mail/courier-imap"

src_compile() {
	#nothing to compile
	echo "Nothing to compile"
}

src_install () {
	dodir ${HTTPD_ROOT}/${P}
	dosym ${HTTPD_ROOT}/${P} ${HTTPD_ROOT}/${PN}
	cp -r . ${D}/${HTTPD_ROOT}/${P}
}

