# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/daaplib/daaplib-0.1.1a.ebuild,v 1.1 2004/03/25 06:29:04 eradicator Exp $

DESCRIPTION="a tiny, portable C++ library to read and write low-level DAAP streams in memory"
HOMEPAGE="http://www.deleet.de/projekte/daap/daaplib/"
SRC_URI="http://deleet.de/projekte/daap/daaplib/${PN}.${PV}.zip"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="static"
DEPEND="app-arch/unzip"
RDEPEND=""

S=${WORKDIR}/${PN}.${PV}/daaplib/src

src_compile() {
	# There is no configure step
	emake || die

	if use static; then
		ranlib libdaaplib.a
	else
		c++ -shared --soname=libdaaplib.so -o libdaaplib.so taginput.o tagoutput.o registry.o
	fi
}

src_install() {
	# Not an autoconf make file :(

	if use static; then
		dolib.a libdaaplib.a
	else
		dolib.so libdaaplib.so
	fi

	mkdir -p ${D}/usr/include/
	cp -r ../include/daap ${D}/usr/include/
	chmod -R a+r ${D}/usr/include/daap

	dodoc ../../COPYING ../../README
}
