# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/qwt/qwt-4.2.0_rc2-r3.ebuild,v 1.2 2004/10/26 09:23:19 phosphan Exp $

inherit eutils

MY_PV="${PV/_r/r}"

SRC_URI="mirror://sourceforge/qwt/${PN}-${MY_PV}.tar.bz2"
HOMEPAGE="http://qwt.sourceforge.net/"
DESCRIPTION="2D plotting library for Qt"
LICENSE="qwt"
KEYWORDS="~x86 ~amd64 ~ppc"
SLOT="0"
IUSE="doc"

S="${WORKDIR}/${PN}-${MY_PV}"
QWTVER="4.2.0"

DEPEND=">=x11-libs/qt-3.0.0
	>=sys-apps/sed-4"


src_unpack () {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-plugin.patch
	find . -type f -name "*.pro" | while read file; do
		sed -e 's/.*no-exceptions.*//g' -i ${file}
		echo >> ${file} "QMAKE_CFLAGS_RELEASE += ${CFLAGS}"
		echo >> ${file} "QMAKE_CXXFLAGS_RELEASE += ${CXXFLAGS}"
	done
	find examples -type f -name "*.pro" | while read file; do
		echo >> ${file} "INCLUDEPATH += /usr/include/qwt"
	done
}

src_compile () {
	addwrite ${QTDIR}/etc/settings
	qmake qwt.pro
	emake || die
	cd designer
	qmake qwtplugin.pro
	emake || die
}

src_install () {
	ls -l lib
	dolib lib/libqwt.so.${QWTVER}
	dosym libqwt.so.${QWTVER} /usr/lib/libqwt.so
	dosym libqwt.so.${QWTVER} /usr/lib/libqwt.so.${QWTVER/.*/}
	use doc && (dodir /usr/share/doc/${PF}
				cp -a examples ${D}/usr/share/doc/${PF}/
				dohtml doc/html/*)
	mkdir -p ${D}/usr/include/qwt/
	find include -type f -name "*.h" | while read file; do
		sed -e 's:include "qwt:include "qwt/qwt:' -i ${file}
	done
	install include/* ${D}/usr/include/qwt/
	insinto ${QTDIR}/plugins/designer
	doins designer/plugins/designer/libqwtplugin.so
}
