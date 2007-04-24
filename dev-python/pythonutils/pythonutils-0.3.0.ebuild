# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pythonutils/pythonutils-0.3.0.ebuild,v 1.2 2007/04/24 08:10:58 lucass Exp $

NEED_PYTHON=2.2

inherit distutils

DESCRIPTION="Voidspace python modules"
HOMEPAGE="http://www.voidspace.org.uk/python/pythonutils.html"
SRC_URI="http://www.voidspace.org.uk/cgi-bin/voidspace/downman.py?file=${P}.zip"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-arch/unzip"
RDEPEND=""

src_install() {
	distutils_src_install

	dodoc docs/*.txt
	dohtml -r docs/*
}
