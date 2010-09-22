# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/networkx/networkx-1.3.ebuild,v 1.1 2010/09/22 16:24:31 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="*:2.6"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.4 2.5"

inherit distutils

DESCRIPTION="Python tools to manipulate graphs and complex networks"
HOMEPAGE="http://networkx.lanl.gov http://pypi.python.org/pypi/networkx"
SRC_URI="http://networkx.lanl.gov/download/networkx/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="examples"

DEPEND="dev-python/setuptools"
RDEPEND="examples? (
		dev-python/matplotlib
		dev-python/pygraphviz
		dev-python/pyparsing
		dev-python/pyyaml
		sci-libs/scipy
	)"

src_install() {
	distutils_src_install
	rm -f "${ED}"usr/share/doc/${PF}/{INSTALL,LICENSE}.txt
	use examples || rm -r "${ED}"usr/share/doc/${PF}/examples
}
