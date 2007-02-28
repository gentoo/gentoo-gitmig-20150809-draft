# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/configobj/configobj-4.3.2.ebuild,v 1.1 2007/02/28 00:28:21 dev-zero Exp $

NEED_PYTHON=2.3

inherit distutils

KEYWORDS="~amd64 ~x86"

DESCRIPTION="Simple but powerful config file reader and writer: an ini file round tripper."
HOMEPAGE="http://www.voidspace.org.uk/python/configobj.html"
SRC_URI="mirror://sourceforge/${PN}/${P}.zip"
LICENSE="BSD"
SLOT="0"
IUSE="doc"

DEPEND="app-arch/unzip"
RDEPEND=""

src_install() {
	DOCS="CONFIGOBJ_CHANGELOG_TODO.txt docs/configobj.txt docs/validate.txt"
	distutils_src_install

	if use doc ; then
		dohtml -r docs/*
		docinto html/api
		dohtml configobj-api/*
	fi
}
