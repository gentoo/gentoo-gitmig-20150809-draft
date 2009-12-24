# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/py/py-1.1.1-r1.ebuild,v 1.2 2009/12/24 08:37:28 grobian Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="A library aiming to support agile and test-driven python development on various levels."
SRC_URI="http://pypi.python.org/packages/source/p/${PN}/${P}.tar.gz"
HOMEPAGE="http://codespeak.net/py/ http://pypi.python.org/pypi/py"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~ia64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE=""

DEPEND=">=dev-python/setuptools-0.6.2"
RDEPEND=""

src_install() {
	distutils_src_install

	python_generate_wrapper_scripts -E -f -q "${D%/}${EPREFIX}/usr/bin/py.test"
}
