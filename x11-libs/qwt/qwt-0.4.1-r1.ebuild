# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/qwt/qwt-0.4.1-r1.ebuild,v 1.3 2003/09/07 00:23:28 msterret Exp $

SRC_URI="mirror://sourceforge/qwt/qwt-${PV}.tar.bz2"
HOMEPAGE="http://qwt.sourceforge.net/"
DESCRIPTION="2D plotting library for Qt"
LICENSE="LGPL-2.1"
KEYWORDS="x86"
SLOT="0"
IUSE="doc"

DEPEND=">=x11-libs/qt-3.0.0"

src_compile () {
	qmake qwt.pro
	emake || die
}

src_install () {
	dolib lib/libqwt.so.${PV}
	dosym libqwt.so.${PV} /usr/lib/libqwt.so
	use doc && (dohtml doc/html/*; cp -a examples ${D}/usr/share/doc/${PF}/;\
				find ${D}/usr/share/doc/ -type f -exec gzip {} \; )
	doman doc/man/man*/*
	mkdir -p ${D}/usr/include/qwt/
	install include/* ${D}/usr/include/qwt/
}
