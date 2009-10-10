# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/mock/mock-0.6.0.ebuild,v 1.2 2009/10/10 11:55:02 arfrever Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="Python mocking library using action -> assertion pattern"
HOMEPAGE="http://www.voidspace.org.uk/python/mock/"
SRC_URI="http://www.voidspace.org.uk/downloads/${P}.zip"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

DEPEND=""
RDEPEND=""
RESTRICT_PYTHON_ABIS="3.*"

DOCS="docs/*.txt"

src_install() {
	distutils_src_install

	if use doc; then
		dodoc mock.pdf
		dohtml -r html/*
	fi
}

pkg_postinst() {
	python_mod_optimize mock.py
}
