# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pykde/pykde-3.5.2.ebuild,v 1.4 2003/04/29 10:42:32 brain Exp $

inherit eutils

MAJ_PV=${PV%.[0-9]*}
MIN_PV=${PV##*[0-9].}
MY_PN="PyKDE"
MY_P=${MY_PN}-${MAJ_PV}-${MIN_PV}

S=${WORKDIR}/${MY_P}
DESCRIPTION="set of Python bindings for the KDE libs"
SRC_URI="http://www.river-bank.demon.co.uk/download/PyKDE2/${MY_P}.tar.gz"
HOMEPAGE="http://www.riverbankcomputing.co.uk/pykde/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

DEPEND="virtual/glibc
	sys-devel/libtool
	>=dev-lang/python-2.2.1
	=dev-python/sip-3.5
	=dev-python/PyQt-3.5-r1
	kde-base/kdelibs"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-sandbox-patch.diff
}

src_compile() {
	dodir /usr/lib/python2.2/site-packages
	dodir /usr/include/python2.2
	python build.py \
		-d ${D}/usr/lib/python2.2/site-packages \
		-s /usr/lib/python2.2/site-packages \
		-u ${KDEDIR}/lib \
		-c -l qt-mt -v /usr/share/sip/qt || die
	make || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc ChangeLog AUTHORS THANKS README
	dodir /usr/share/doc/${PF}/
	mv ${D}/usr/share/doc/* ${D}/usr/share/doc/${PF}/
}
