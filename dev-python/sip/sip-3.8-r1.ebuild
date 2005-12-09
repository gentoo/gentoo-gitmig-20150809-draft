# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/sip/sip-3.8-r1.ebuild,v 1.12 2005/12/09 22:00:47 carlo Exp $

inherit eutils distutils

MY_P="${PN}-x11-gpl-${PV}"
DESCRIPTION="SIP is a tool for generating bindings for C++ classes so that they can be used by Python."
SRC_URI="mirror://gentoo/${MY_P}.tar.gz"
HOMEPAGE="http://www.riverbankcomputing.co.uk/sip/"

SLOT="0"
LICENSE="sip"
KEYWORDS="x86 ppc sparc alpha"
IUSE=""

DEPEND="virtual/libc
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

	emake || die
}

src_install() {
	distutils_python_version
	dodir /usr/include/python${PYVER}
	emake || die
	einstall || die
	dodoc NEWS README THANKS
}
