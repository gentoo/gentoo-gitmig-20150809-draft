# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/sip/sip-4.0_rc2.ebuild,v 1.2 2004/01/30 21:42:37 ferringb Exp $

IUSE=""

inherit eutils distutils

MY_P=${P/_/}
S=${WORKDIR}/${MY_P}

DESCRIPTION="SIP is a tool for generating bindings for C++ classes so that they can be used by Python."
SRC_URI="http://www.river-bank.demon.co.uk/download/sip/${MY_P}.tar.gz"
HOMEPAGE="http://www.riverbankcomputing.co.uk/sip/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc"
#note, python-2.3 isn't keyworded for alpha yet.
# ~alpha"

DEPEND="virtual/glibc
	x11-libs/qt
	>=dev-lang/python-2.3"

src_compile(){
	distutils_python_version
	dodir /usr/bin
	dodir /usr/lib/python${PYVER}/site-packages
	python configure.py -l qt-mt \
		-b ${D}usr/bin \
		-d ${D}usr/lib/python${PYVER}/site-packages \
		-e ${D}usr/include/python${PYVER} \
		"CXXFLAGS+=${CXXFLAGS}"
	make || die
}

src_install() {
	distutils_python_version
	dodir /usr/include/python${PYVER}
	make install || die
	echo "/${D//\//\\/}/s//\//" > fixpaths.sed
	sed -i -f fixpaths.sed ${D}usr/lib/python${PYVER}/site-packages/sipconfig.py
	dodoc ChangeLog LICENS NEWS README THANKS TODO
}
