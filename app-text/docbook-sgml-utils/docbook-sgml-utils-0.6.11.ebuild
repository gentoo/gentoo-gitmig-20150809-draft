# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-text/docbook-sgml-utils/docbook-sgml-utils-0.6.11.ebuild,v 1.1 2002/07/05 14:30:51 seemant Exp $

MY_PN=${PN/-sgml/}
MY_P=${MY_PN}-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Shell scripts to manage DocBook documents"
SRC_URI="ftp://sources.redhat.com/pub/docbook-tools/new-trials/SOURCES/${MY_P}.tar.gz"
HOMEPAGE="http://sources.redhat.com/docbook-tools/"

SLOT=""
LICENSE="GPL-2"

DEPEND=">=sys-devel/perl-5
	app-text/docbook-xml-simple-dtd
	app-text/docbook-xml-dtd
	app-text/docbook-sgml-dtd"


src_compile() {

	econf || die
	make || die

}

src_install () {

	einstall || die
	dodoc AUTHORS COPYING ChangeLog NEWS README TODO
	mv ${D}/usr/doc/html/${MY_P} ${D}/usr/share/doc/${P}/html
	rm -r ${D}/usr/doc/
}
