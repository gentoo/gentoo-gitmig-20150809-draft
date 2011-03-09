# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/manuel/manuel-1.5.0.ebuild,v 1.1 2011/03/09 21:51:31 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"
DISTUTILS_SRC_TEST="setup.py"

inherit distutils

DESCRIPTION="Manuel lets you build tested documentation."
HOMEPAGE="http://packages.python.org/manuel/ http://pypi.python.org/pypi/manuel"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
IUSE="test"

DEPEND="dev-python/setuptools
	test? ( net-zope/zope-testing )"
RDEPEND=""

DOCS="CHANGES.txt"
