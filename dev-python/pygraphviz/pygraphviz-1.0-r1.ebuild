# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pygraphviz/pygraphviz-1.0-r1.ebuild,v 1.3 2011/06/22 19:01:32 grobian Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils eutils

DESCRIPTION="Python wrapper for the Graphviz Agraph data structure"
HOMEPAGE="http://networkx.lanl.gov/pygraphviz/ http://pypi.python.org/pypi/pygraphviz"
SRC_URI="http://networkx.lanl.gov/download/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-linux ~ppc-macos ~x64-macos ~x86-macos"
IUSE="examples"

RDEPEND=">=media-gfx/graphviz-2.12"
DEPEND="${RDEPEND}"

src_prepare() {
	distutils_src_prepare
	epatch "${FILESDIR}/${P}-setup.py.patch"
	epatch "${FILESDIR}/${P}-avoid_tests.patch"
}

src_test() {
	testing() {
		"$(PYTHON)" -c "import sys; sys.path.insert(0, '$(ls -d build-${PYTHON_ABI}/lib.*)'); import pygraphviz.tests; pygraphviz.tests.run()"
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples || die "Installation of examples failed"
	fi

	delete_tests() {
		rm -fr "${ED}$(python_get_sitedir)/${PN}/tests"
	}
	python_execute_function -q delete_tests
}
