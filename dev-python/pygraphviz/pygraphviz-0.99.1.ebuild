# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pygraphviz/pygraphviz-0.99.1.ebuild,v 1.4 2010/06/30 01:03:35 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils eutils

DESCRIPTION="Python bindings for the agraph library in the graphviz package."
HOMEPAGE="http://networkx.lanl.gov/pygraphviz/ http://pypi.python.org/pypi/pygraphviz"
SRC_URI="http://networkx.lanl.gov/download/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="examples"

RDEPEND=">=media-gfx/graphviz-2.12"
DEPEND="${RDEPEND}"

src_prepare() {
	distutils_src_prepare
	epatch "${FILESDIR}/${P}-setup.py.patch"
}

src_test() {
	testing() {
		"$(PYTHON)" -c "import sys; sys.path.insert(0, '$(ls -d build-${PYTHON_ABI}/lib.*)'); import pygraphviz; pygraphviz.test()"
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples || die
	fi
}
