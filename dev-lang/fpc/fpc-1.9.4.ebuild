# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/fpc/fpc-1.9.4.ebuild,v 1.1 2004/09/08 04:26:44 chriswhite Exp $

inherit rpm

DESCRIPTION="The Free Pascal compiler"
HOMEPAGE="http://www.freepascal.org/"
SRC_URI="ftp://ftp.freepascal.org/pub/fpc/beta/linux-i386-${PV}/${P}-0.i586.rpm"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 -*"
IUSE=""
DEPEND="virtual/libc
		!dev-lang/fpc-source"
S=${WORKDIR}

src_unpack() {
	rpm_unpack ${DISTDIR}/${P}-0.i586.rpm
}

src_install() {
	mv ${WORKDIR}/usr ${D}
	cd ${D}
	mv usr/share/doc/packages/${P} usr/share/doc/${P}
	rmdir usr/share/doc/packages
	chmod -R 755 usr/lib/* usr/share/*
}
