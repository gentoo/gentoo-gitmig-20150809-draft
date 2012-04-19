# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/py3dns/py3dns-3.0.1.ebuild,v 1.1 2012/04/19 08:42:33 patrick Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="Python3 module for DNS (Domain Name Service)"
HOMEPAGE="http://pydns.sourceforge.net/ http://pypi.python.org/pypi/pydns"
SRC_URI="http://downloads.sourceforge.net/project/pydns/${PN}/${P}.tar.gz"

LICENSE="CNRI"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples"

DEPEND="virtual/libiconv"
RDEPEND=""
RESTRICT_PYTHON_ABIS="2.*"

DOCS="CREDITS.txt"
PYTHON_MODNAME="DNS"

src_prepare() {
	# Don't compile bytecode.
	sed -i -e 's:^\(compile\).*:\1 = 0:g' -e 's:^\(optimize\).*:\1 = 0:g' setup.cfg
}

src_install(){
	distutils_src_install

	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins tests/*.py tools/*.py
	fi
}
