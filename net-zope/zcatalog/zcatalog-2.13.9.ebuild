# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/zcatalog/zcatalog-2.13.9.ebuild,v 1.1 2011/04/10 14:01:47 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2:2.6"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.4 2.5 3.* *-jython"

inherit distutils

MY_PN="Products.ZCatalog"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Zope 2's indexing and search solution."
HOMEPAGE="http://pypi.python.org/pypi/Products.ZCatalog"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.zip"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND="dev-python/restrictedpython
	net-zope/accesscontrol
	net-zope/acquisition
	net-zope/datetime
	net-zope/documenttemplate
	net-zope/extensionclass
	net-zope/missing
	net-zope/persistence
	net-zope/record
	net-zope/zexceptions
	net-zope/zodb
	>=net-zope/zope-2.12
	net-zope/zope-dottedname
	net-zope/zope-interface
	net-zope/zope-schema
	net-zope/zope-testing"
DEPEND="${RDEPEND}
	app-arch/unzip
	dev-python/setuptools"
PDEPEND="net-zope/zctextindex"

S="${WORKDIR}/${MY_P}"

DOCS="CHANGES.txt README.txt"
PYTHON_MODNAME="Products/PluginIndexes ${MY_PN/.//}"
