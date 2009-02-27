# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pygraphviz/pygraphviz-0.99.1.ebuild,v 1.1 2009/02/27 20:49:23 bicatali Exp $

EAPI=2
NEED_PYTHON="2.4"
inherit distutils

DESCRIPTION="Python bindings for the agraph library in the graphviz package."
HOMEPAGE="http://networkx.lanl.gov/pygraphviz/"
SRC_URI="http://networkx.lanl.gov/download/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples"

RDEPEND=">=media-gfx/graphviz-2.12"
DEPEND="${RDEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-setup.py.patch
}

src_test() {
	cd build/lib*
	PYTHONPATH=. ${python} -c "import pygraphviz; pygraphviz.test()" \
		|| die "tests failed"
}

src_install() {
	distutils_src_install
	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples || die
	fi
}
