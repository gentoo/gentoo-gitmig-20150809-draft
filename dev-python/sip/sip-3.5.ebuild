# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/sip/sip-3.5.ebuild,v 1.5 2003/02/28 16:54:59 liquidx Exp $

MY_P="${PN}-x11-gpl-${PV}"
DESCRIPTION="SIP is a tool for generating bindings for C++ classes so that they can be used by Python."
SRC_URI="http://www.river-bank.demon.co.uk/download/sip/${MY_P}.tar.gz"
HOMEPAGE="http://www.riverbankcomputing.co.uk/sip/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc alpha"

DEPEND="virtual/glibc
	x11-libs/qt
	>=dev-lang/python-2.2.1"

S=${WORKDIR}/${MY_P}

src_unpack() {

	unpack ${MY_P}.tar.gz
	cd ${S}
	patch -p0 < ${FILESDIR}/license-3.5.diff

}

src_compile(){
	chmod +x build.py
	dodir /usr/bin
	dodir /usr/lib/python2.2/site-packages
	python build.py -l qt-mt -b ${D}/usr/bin -d ${D}/usr/lib/python2.2/site-packages \
			-e ${D}/usr/include/python2.2
	make || die
}

src_install() {
	dodir /usr/include/python2.2
	make DESTDIR=${D} install || die
	dodoc NEWS README THANKS
}
