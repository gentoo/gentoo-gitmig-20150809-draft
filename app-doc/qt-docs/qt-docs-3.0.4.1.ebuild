# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-doc/qt-docs/qt-docs-3.0.4.1.ebuild,v 1.3 2002/07/18 23:03:29 drobbins Exp $
# qt-copy-3.0.4 (released with kde-3.0.1)

NPV=3.0.4
S=${WORKDIR}/qt-copy-3.0.4
SRC_URI="ftp://ftp.kde.org/pub/kde/stable/3.0.1/src/qt-copy-${NPV}.tar.bz2"
HOMEPAGE="http://www.trolltech.com/"
DEPEND="=x11-libs/qt-3*"
RDEPEND="$DEPEND sys-devel/gcc"
DESCRIPTION="Documentation for the QT ${NPV} API"
KEYWORDS="x86 sparc sparc64 ppc"
SLOT="3"
LICENSE="QPL-1.0"

pkg_setup() {
	QTBASE=/usr/qt/3
	export QTDIR=${S}
}

src_compile() {
	einfo "Nothing to compile."
}

src_install() {
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


