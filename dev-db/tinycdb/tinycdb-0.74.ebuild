# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/tinycdb/tinycdb-0.74.ebuild,v 1.5 2004/10/17 10:04:07 hattya Exp $

inherit eutils

IUSE=""

DESCRIPTION="TinyCDB is a very fast and simple package for creating and reading constant data bases"
HOMEPAGE="http://www.corpit.ru/mjt/tinycdb.html"
SRC_URI="http://www.corpit.ru/mjt/tinycdb/${P}.tar.gz"

LICENSE="public-domain"
KEYWORDS="x86 ~ppc ia64"
SLOT="0"

DEPEND=""

src_unpack() {

	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-libbase.diff

}

src_compile() {

	emake LIBBASE=lib${PN} all shared || die

}

src_install() {

	einstall LIBBASE=lib${PN} install-shared || die

	mv ${D}/usr/include/{cdb,${PN}}.h

}
