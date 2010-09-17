# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/zctextindex/zctextindex-2.13.0.ebuild,v 1.1 2010/09/17 22:10:38 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2:2.6"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.4 2.5 3.*"

inherit distutils

MY_PN="Products.ZCTextIndex"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Full text indexing for ZCatalog / Zope 2."
HOMEPAGE="http://pypi.python.org/pypi/Products.ZCTextIndex"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.zip"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~sparc ~x86"
IUSE=""

RDEPEND="net-zope/accesscontrol
	net-zope/acquisition
	net-zope/persistence
	net-zope/transaction
	net-zope/zexceptions
	net-zope/zodb
	>=net-zope/zope-2.12
	net-zope/zope-interface"
DEPEND="${RDEPEND}
	app-arch/unzip
	dev-python/setuptools"

S="${WORKDIR}/${MY_P}"

DOCS="CHANGES.txt src/Products/ZCTextIndex/README.txt"
PYTHON_MODNAME="${MY_PN/.//}"

src_prepare() {
	distutils_src_prepare

	# http://svn.zope.org/?rev=114425&view=rev
	sed -e "/packages=/a namespace_packages=['Products']," -i setup.py || die "sed failed"
}
