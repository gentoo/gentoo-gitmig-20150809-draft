# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/fpc/fpc-1.0.10.ebuild,v 1.8 2004/08/21 18:20:02 chriswhite Exp $

DESCRIPTION="The Free Pascal compiler"
HOMEPAGE="http://www.freepascal.org/"
SRC_URI="ftp://ftp.freepascal.org/pub/fpc/dist/Linux/rpm/${P}-0.i386.rpm"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 -*"
IUSE=""
DEPEND="virtual/libc
	app-arch/rpm2targz
	!dev-lang/fpc-source"
RDEPEND="virtual/libc"
S=${WORKDIR}

src_unpack() {
	rpm2targz ${DISTDIR}/${P}-0.i386.rpm
}

src_compile() {
	einfo Nothing to compile
}

src_install() {
	cd ${D}
	tar -xzf ${WORKDIR}/${P}-0.i386.tar.gz
	# correct paths where mans go
	mv usr/share/man/man/* usr/share/man/
	rmdir usr/share/man/man
	mv usr/share/doc/packages/${P} usr/share/doc/${P}
	rmdir usr/share/doc/packages
	chmod -R 755 usr/lib/* usr/share/*
}
