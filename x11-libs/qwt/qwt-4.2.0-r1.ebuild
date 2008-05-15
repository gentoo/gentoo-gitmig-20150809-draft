# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/qwt/qwt-4.2.0-r1.ebuild,v 1.10 2008/05/15 12:53:55 grozin Exp $

inherit multilib

MY_PV="${PV/_r/r}"

SRC_URI="mirror://sourceforge/qwt/${PN}-${MY_PV}.tar.bz2"
HOMEPAGE="http://qwt.sourceforge.net/"
DESCRIPTION="2D plotting library for Qt"
LICENSE="qwt"
KEYWORDS="amd64 ia64 ~ppc ppc64 x86"
SLOT="0"
IUSE="doc"

S="${WORKDIR}/${PN}-${MY_PV}"
QWTVER="4.2.0"

DEPEND="=x11-libs/qt-3*
	>=sys-apps/sed-4"

src_unpack () {
	unpack ${A}
	cd "${S}"
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
	${QTDIR}/bin/qmake QMAKE=${QTDIR}/bin/qmake qwt.pro
	emake || die
	cd designer
	${QTDIR}/bin/qmake QMAKE=${QTDIR}/bin/qmake qwtplugin.pro
	emake || die
}

src_install () {
	ls -l lib
	dolib lib/libqwt.so.${QWTVER}
	dosym libqwt.so.${QWTVER} /usr/$(get_libdir)/libqwt.so
	dosym libqwt.so.${QWTVER} /usr/$(get_libdir)/libqwt.so.${QWTVER/.*/}
	use doc && (dodir /usr/share/doc/${PF}
				cp -pPR examples "${D}"/usr/share/doc/${PF}/
				dohtml doc/html/*)
	mkdir -p "${D}"/usr/include/qwt/
	install include/* "${D}"/usr/include/qwt/
	insinto ${QTDIR}/plugins/designer
	doins designer/plugins/designer/libqwtplugin.so
}
