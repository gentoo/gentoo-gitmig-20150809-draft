# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/dap/dap-2.2.6.7.ebuild,v 1.4 2010/07/22 15:24:23 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="Data Access Protocol client and server"
HOMEPAGE="http://pydap.org http://pypi.python.org/pypi/dap http://pypi.python.org/pypi/Pydap"
SRC_URI="http://pypi.python.org/packages/source/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="server"

RDEPEND="dev-python/httplib2
	server? (
		dev-python/cheetah
		dev-python/paste
		dev-python/pastedeploy
		dev-python/pastescript
	)"
DEPEND="${RDEPEND}
	dev-python/setuptools"

DOCS="docs/bugs docs/Changelog docs/history"

src_prepare() {
	distutils_src_prepare
	sed -e "s/'dap.plugins'/'dap', 'dap.plugins'/" -i setup.py || die "sed failed"
}
