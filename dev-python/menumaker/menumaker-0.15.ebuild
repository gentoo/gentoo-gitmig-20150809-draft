# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/menumaker/menumaker-0.15.ebuild,v 1.2 2003/12/29 16:36:51 g2boojum Exp $

inherit distutils

MY_P=${P/menumaker/MenuMaker}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Utility that scans through the system and generates a menu of installed programs"
HOMEPAGE="http://menumaker.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND=">=dev-lang/python-2.1"

PYTHON_MODNAME="MenuMaker Prophet"

src_compile() {
	echo "Nothing to compile"
}

src_install() {
	distutils_python_version
	dodir /usr/lib/python${PYVER}/site-packages
	cp -r MenuMaker Prophet ${D}/usr/lib/python${PYVER}/site-packages
	dobin mmaker mmaker-launch
	dodoc CHANGES COPYING README
}

