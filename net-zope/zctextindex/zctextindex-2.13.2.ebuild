# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/zctextindex/zctextindex-2.13.2.ebuild,v 1.1 2011/05/04 20:21:40 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2:2.6"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.4 2.5 3.* *-jython"

inherit distutils

MY_PN="Products.ZCTextIndex"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Full text indexing for ZCatalog / Zope 2."
HOMEPAGE="http://pypi.python.org/pypi/Products.ZCTextIndex"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.zip"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND="net-zope/accesscontrol
	net-zope/acquisition
	net-zope/persistence
	net-zope/transaction
	net-zope/zcatalog
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
