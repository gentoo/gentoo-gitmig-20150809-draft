# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/yolk/yolk-0.4.1.ebuild,v 1.3 2010/12/26 15:53:15 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="Tool and library for querying PyPI and locally installed Python packages"
HOMEPAGE="http://pypi.python.org/pypi/yolk"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples"

DEPEND="dev-python/setuptools"
RDEPEND="dev-python/yolk-portage"

src_install() {
	distutils_src_install

	if use examples; then
		docinto examples/plugins
		dodoc examples/plugins/*
		docinto examples/plugins/yolk_portage
		dodoc examples/plugins/yolk_portage/*
		docinto examples/plugins/yolk_pkg_manager
		dodoc examples/plugins/yolk_pkg_manager/*
		prepalldocs
	fi
}
