# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2 
# $Header: /var/cvsroot/gentoo-x86/x11-libs/qwt/qwt-0.4.2_pre20030129.ebuild,v 1.1 2003/04/25 08:58:45 phosphan Exp $

SRC_URI="mirror://sourceforge/qwt/qwt-20030129.tgz"
HOMEPAGE="http://qwt.sourceforge.net/"
DESCRIPTION="2D plotting library for Qt"
LICENSE="qwt"
KEYWORDS="~x86" 
SLOT="0"
IUSE="doc"

S="${WORKDIR}/qwt-20030129"
QWTVER="0.4.2"

DEPEND=">=x11-libs/qt-3.0.0"

src_compile () {
	qmake qwt.pro
	emake || die
	cd designer
	qmake qwtplugin.pro
	emake || die
}

src_install () {
	dolib lib/libqwt.so.${QWTVER}
	dosym libqwt.so.${QWTVER} /usr/lib/libqwt.so
	use doc && (cp -a examples ${D}/usr/share/doc/${PF}/;\
				find ${D}/usr/share/doc/ -type f -exec gzip {} \;;\
				dohtml doc/html/*)				 
	#doman doc/man/man*/*
	mkdir -p ${D}/usr/include/qwt/
	install include/* ${D}/usr/include/qwt/
	insinto ${QTDIR}/plugins/designer
	doins designer/plugins/designer/libqwtplugin.so 
}
