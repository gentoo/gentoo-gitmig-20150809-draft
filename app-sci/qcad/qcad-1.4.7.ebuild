# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Eric Sorton <erics@cfl.rr.com> and Scott Claridge <scott.claridge@bigfoot.com>
# $Header: /var/cvsroot/gentoo-x86/app-sci/qcad/qcad-1.4.7.ebuild,v 1.1 2002/05/02 00:03:52 seemant Exp $

MY_P=${P}-src
S=${WORKDIR}/${MY_P}
DESCRIPTION="A 2D CAD package based upon Qt."
SRC_URI="http://www.qcad.org/archives/${MY_P}.tar.gz"
HOMEPAGE="http://www.qcad.org"

DEPEND=">=dev-util/tmake-1.8-r1 
	=x11-libs/qt-2.3*"

src_compile() {
	export QTDIR=/usr/qt/2
	cd ${S}
    tmake qcad.pro -o Makefile
	emake CXXFLAGS="$CXXFLAGS" || die
}

src_install () {
	dobin qcad

	dohtml -r doc

	dodoc AUTHORS COPYING INSTALL MANIFEST README TODO changes-1.4.8 changes-old
	docinto examples
	dodoc examples/*

	dodir /usr/share/${PN}
	cp -a fonts hatches libraries messages templates ${D}/usr/share/${PN}

	insinto /usr/share/${PN}/pixmaps
	doins xpm/*
}
