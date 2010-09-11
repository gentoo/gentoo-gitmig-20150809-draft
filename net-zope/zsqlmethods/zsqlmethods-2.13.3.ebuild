# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/zsqlmethods/zsqlmethods-2.13.3.ebuild,v 1.1 2010/09/11 21:47:18 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2:2.6"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.4 2.5 3.*"

inherit distutils

MY_PN="Products.ZSQLMethods"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="SQL method support for Zope 2."
HOMEPAGE="http://pypi.python.org/pypi/Products.ZSQLMethods"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.zip"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~sparc ~x86"
IUSE=""

RDEPEND="net-zope/accesscontrol
	net-zope/acquisition
	net-zope/datetime
	net-zope/documenttemplate
	net-zope/extensionclass
	net-zope/missing
	net-zope/persistence
	net-zope/record
	net-zope/transaction
	net-zope/zexceptions
	net-zope/zodb
	>=net-zope/zope-2.12.9"
DEPEND="${RDEPEND}
	app-arch/unzip
	dev-python/setuptools"

S="${WORKDIR}/${MY_P}"

DOCS="CHANGES.txt README.txt"
PYTHON_MODNAME="${MY_PN/.//} Shared/DC/ZRDB"
