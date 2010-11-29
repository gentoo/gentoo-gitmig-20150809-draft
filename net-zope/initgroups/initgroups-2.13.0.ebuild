# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/initgroups/initgroups-2.13.0.ebuild,v 1.3 2010/11/29 02:05:02 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"

inherit distutils

DESCRIPTION="Convenience uid/gid helper function used in Zope2."
HOMEPAGE="http://pypi.python.org/pypi/initgroups"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.zip"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~sparc ~x86"
IUSE=""

DEPEND="app-arch/unzip
	dev-python/setuptools"
RDEPEND=""

DOCS="CHANGES.txt README.txt"

src_install() {
	distutils_src_install
	python_clean_installation_image
}
