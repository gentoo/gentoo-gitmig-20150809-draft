# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/elementtree/elementtree-1.2.4.ebuild,v 1.1 2005/01/24 06:20:42 pythonhead Exp $

inherit distutils

MY_P="${PN}-${PV}-20041228"
DESCRIPTION="A light-weight XML object model for Python"
HOMEPAGE="http://effbot.org/zone/element-index.htm"
SRC_URI="http://effbot.org/downloads/${MY_P}.zip"
KEYWORDS="~x86 ~ppc ~amd64"
DEPEND="virtual/python"
RDEPEND="${DEPEND}
	app-arch/unzip"
LICENSE="as-is"
SLOT="0"
IUSE=""
S=${WORKDIR}/${MY_P}

src_test() {
	python selftest.py || die "selftest.py failed"
}

src_install() {
	distutils_src_install

	dodoc CHANGES
	dohtml docs/*
}
