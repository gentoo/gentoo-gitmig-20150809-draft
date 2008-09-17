# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/menumaker/menumaker-0.17.ebuild,v 1.4 2008/09/17 21:27:57 coldwind Exp $

inherit distutils

MY_P=${P/menumaker/MenuMaker}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Utility that scans through the system and generates a menu of installed programs"
HOMEPAGE="http://menumaker.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~ppc x86 ~x86-fbsd"
IUSE=""

DEPEND=">=dev-lang/python-2.1"

PYTHON_MODNAME="MenuMaker Prophet"

src_compile() {
	echo "Nothing to compile"
}

src_install() {
	distutils_python_version
	dodir /usr/lib/python${PYVER}/site-packages
	cp -r MenuMaker Prophet "${D}"/usr/lib/python${PYVER}/site-packages
	dobin mmaker mmaker-launch
	dodoc CHANGES README
}
