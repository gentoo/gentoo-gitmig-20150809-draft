# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/manuel/manuel-1.3.0.ebuild,v 1.1 2010/10/17 17:02:38 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="Manuel lets you build tested documentation."
HOMEPAGE="http://packages.python.org/manuel/ http://pypi.python.org/pypi/manuel"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="net-zope/zope-testrunner"
DEPEND="${RDEPEND}
	dev-python/setuptools"

DOCS="CHANGES.txt"
