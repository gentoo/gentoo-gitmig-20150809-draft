# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/qt-docs/qt-docs-3.1.2.ebuild,v 1.3 2003/05/21 15:27:05 weeve Exp $

IUSE=""
S=${WORKDIR}/qt-x11-free-${PV}
SRC_URI="ftp://ftp.trolltech.com/qt/source/qt-x11-free-${PV}.tar.bz2"
HOMEPAGE="http://www.trolltech.com/"
DESCRIPTION="Documentation for the QT ${PV} API"
KEYWORDS="x86 sparc ~ppc ~alpha"
SLOT="3"
LICENSE="QPL-1.0"

src_compile() {
	einfo "Nothing to compile."
}

src_install() {
	QTBASE=/usr/qt/3
	export QTDIR=${S}
	cd ${S}
	# misc
	insinto /etc/env.d
	doins ${FILESDIR}/45qt-docs3

	# docs
	cd ${S}/doc
	dodir ${QTBASE}/doc
	for x in html flyers; do
		cp -r $x ${D}/${QTBASE}/doc
	done

	# manpages
	cp -r ${S}/doc/man ${D}/${QTBASE}
	# examples
	cp -r ${S}/examples ${D}/${QTBASE}
	# tutorials
	cp -r ${S}/tutorial ${D}/${QTBASE}

}
