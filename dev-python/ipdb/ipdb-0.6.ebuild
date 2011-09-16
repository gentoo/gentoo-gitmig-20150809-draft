# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/ipdb/ipdb-0.6.ebuild,v 1.1 2011/09/16 15:59:46 neurogeek Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="IPython-enabled pdb"
HOMEPAGE="http://pypi.python.org/pypi/ipdb"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-python/ipython"
DEPEND="${RDEPEND}
	dev-python/setuptools"

DOCS="HISTORY.txt"
