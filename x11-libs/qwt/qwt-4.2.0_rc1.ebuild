# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/qwt/qwt-4.2.0_rc1.ebuild,v 1.2 2004/04/01 10:13:12 phosphan Exp $

MY_PV="${PV/_r/r}"

SRC_URI="mirror://sourceforge/qwt/${PN}-${MY_PV}.tgz"
HOMEPAGE="http://qwt.sourceforge.net/"
DESCRIPTION="2D plotting library for Qt"
LICENSE="qwt"
KEYWORDS="x86"
SLOT="0"
IUSE="doc"

S="${WORKDIR}/${PN}-${MY_PV}"
QWTVER="4.2.0"

DEPEND=">=x11-libs/qt-3.0.0"

src_compile () {
	addwrite ${QTDIR}/etc/settings
	qmake qwt.pro
	emake || die
	cd designer
	qmake qwtplugin.pro
	emake || die
}

src_install () {
	dolib lib/libqwt.so.${QWTVER}
	dosym libqwt.so.${QWTVER} /usr/lib/libqwt.so

	use doc && (dodir /usr/share/doc/${PF}
				cp -a examples ${D}/usr/share/doc/${PF}/
				find ${D}/usr/share/doc/ -type f -exec gzip {} \;
				dohtml doc/html/*)
	mkdir -p ${D}/usr/include/qwt/
	install include/* ${D}/usr/include/qwt/
	insinto ${QTDIR}/plugins/designer
	doins designer/plugins/designer/libqwtplugin.so
}
