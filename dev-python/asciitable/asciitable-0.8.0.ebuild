# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/asciitable/asciitable-0.8.0.ebuild,v 1.1 2011/10/05 20:06:51 xarthisius Exp $

EAPI="3"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="*-jython"
DISTUTILS_SRC_TEST="nosetests"

inherit distutils

DESCRIPTION="An extensible ASCII table reader"
HOMEPAGE="http://pypi.python.org/pypi/asciitable http://cxc.harvard.edu/contrib/asciitable"
SRC_URI="http://pypi.python.org/packages/source/a/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-python/numpy"
DEPEND="${RDEPEND}"

PYTHON_MODNAME="asciitable.py"

src_install() {
	distutils_src_install
	dodoc CHANGES
}
