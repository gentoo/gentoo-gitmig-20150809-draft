# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/fpc/fpc-1.0.10.ebuild,v 1.1 2003/08/26 21:43:29 hanno Exp $

DESCRIPTION="The Free Pascal compiler"
HOMEPAGE="http://www.freepascal.org/"
SRC_URI="ftp://ftp.freepascal.org/pub/fpc/dist/Linux/rpm/${P}-0.i386.rpm"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 -*"
IUSE=""
DEPEND="virtual/glibc"
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
	chmod -R 755 usr/lib/* usr/share/*
}
