# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/natgrid/natgrid-0.2.1.ebuild,v 1.2 2012/02/23 09:12:21 patrick Exp $

EAPI="3"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* 2.7-pypy-* *-jython"

inherit distutils

DESCRIPTION="Matplotlib toolkit for gridding irreguraly spaced data"
HOMEPAGE="http://matplotlib.sourceforge.net/users/toolkits.html"
SRC_URI="mirror://sourceforge/matplotlib/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-python/matplotlib-0.98"
RDEPEND="${DEPEND}"

PYTHON_MODNAME="mpl_toolkits/natgrid"

src_install() {
	distutils_src_install

	insinto /usr/share/doc/${PF}
	doins test.py || die "doins failed"

	# Fix collision with dev-python/matplotlib.
	delete_mpl_toolkits.__init__() {
		rm -f "${ED}$(python_get_sitedir)/mpl_toolkits/__init__.py"
	}
	python_execute_function -q delete_mpl_toolkits.__init__
}
