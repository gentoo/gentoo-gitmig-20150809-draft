# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-text/docbook-sgml-utils/docbook-sgml-utils-0.6.9.ebuild,v 1.1 2002/04/28 03:10:18 seemant Exp $

MY_PN=${PN/-sgml/}
MY_P=${MY_PN}-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Shell scripts to manage DocBook documents"
SRC_URI="http://ftp.debian.org/debian/pool/main/d/docbook-utils/${MY_PN}_${PV}.orig.tar.gz"
HOMEPAGE="http://packages.debian.org/testing/text/docbook-utils.html"

DEPEND=">=sys-devel/perl-5"

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
