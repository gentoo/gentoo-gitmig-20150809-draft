# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Grant Goodyear <g2boojum@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-mail/squirrelmail/squirrelmail-1.2.2.ebuild,v 1.2 2002/01/02 20:04:52 g2boojum Exp $

PLUGINS=${PN}_plugins-20010604
S=${WORKDIR}/${P}
HTTPD_ROOT="/usr/local/httpd/htdocs"

DESCRIPTION="Webmail for nuts!"

SRC_URI="http://prdownloads.sf.net/${PN}/${P}.tar.bz2
         http://www.squirrelmail.org/plugins/${PLUGINS}.tar"
HOMEPAGE="http://www.squirrelmail.org"

DEPEND="dev-lang/php
        net-www/apache"

RDEPEND="virtual/imap"

src_compile() {
	#nothing to compile
	echo "Nothing to compile"
}

src_install () {
	dodir ${HTTPD_ROOT}/${P}
	dosym ${HTTPD_ROOT}/${P} ${HTTPD_ROOT}/${PN}
	cp -r . ${D}/${HTTPD_ROOT}/${P}
	cd ${D}/${HTTPD_ROOT}/${P}/plugins
	tar xvf ${DISTDIR}/${PLUGINS}.tar
	for name in `ls *.tar.gz`
	do
		tar xvzf ${name}
	done
	cd ${D}/${HTTPD_ROOT}
	chown -R nobody.nobody ${P}
}

