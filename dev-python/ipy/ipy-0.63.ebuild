# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/ipy/ipy-0.63.ebuild,v 1.1 2009/08/28 22:24:02 arfrever Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

MY_P="${P/ip/IP}"

DESCRIPTION="A python Module for handling IP-Addresses and Networks"
HOMEPAGE="http://software.inl.fr/trac/trac.cgi/wiki/IPy"
SRC_URI="http://cheeseshop.python.org/packages/source/I/IPy/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="examples"

DEPEND=""
RDEPEND=""

RESTRICT_PYTHON_ABIS="3*"

S="${WORKDIR}/${MY_P}"

src_test() {
	testing() {
		PYTHONPATH="build-${PYTHON_ABI}/lib" "$(PYTHON)" test/test_IPy.py
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r example
	fi
}

pkg_postinst() {
	python_mod_optimize IPy.py
}

pkg_postrm() {
	python_mod_cleanup
}
