# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/sip/sip-3.6.ebuild,v 1.1 2003/04/29 09:35:43 brain Exp $

IUSE=""

inherit eutils distutils

MY_P="${PN}-x11-gpl-${PV}"
DESCRIPTION="SIP is a tool for generating bindings for C++ classes so that they can be used by Python."
SRC_URI="http://www.river-bank.demon.co.uk/download/sip/${MY_P}.tar.gz"
HOMEPAGE="http://www.riverbankcomputing.co.uk/sip/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"

DEPEND="virtual/glibc
	x11-libs/qt
	>=dev-lang/python-2.2.1"

S=${WORKDIR}/${MY_P}


src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/license-${PV}.diff
}

src_compile(){
	distutils_python_version

	chmod +x build.py
	dodir /usr/bin
	dodir /usr/lib/python${PYVER}/site-packages
	python build.py -l qt-mt \
		-b ${D}/usr/bin \
		-d ${D}/usr/lib/python${PYVER}/site-packages \
		-e ${D}/usr/include/python${PYVER}
		
	make || die
}

src_install() {
	distutils_python_version
	dodir /usr/include/python${PYVER}
	make DESTDIR=${D} install || die
	dodoc NEWS README THANKS
}
