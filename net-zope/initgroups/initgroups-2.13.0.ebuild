# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/initgroups/initgroups-2.13.0.ebuild,v 1.1 2010/07/04 05:41:42 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="Convenience uid/gid helper function used in Zope2."
HOMEPAGE="http://pypi.python.org/pypi/initgroups"
SRC_URI="http://pypi.python.org/packages/source/${PN:0:1}/${PN}/${P}.zip"

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
