# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/btreefolder2/btreefolder2-2.13.1.ebuild,v 1.2 2011/01/14 10:10:46 xarthisius Exp $

EAPI="3"
PYTHON_DEPEND="2:2.6"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.4 2.5 3.*"

inherit distutils

MY_PN="Products.BTreeFolder2"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A BTree based implementation for Zope 2's OFS."
HOMEPAGE="http://pypi.python.org/pypi/Products.BTreeFolder2"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.zip"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND="net-zope/accesscontrol
	net-zope/acquisition
	net-zope/persistence
	net-zope/zodb
	>=net-zope/zope-2.12
	net-zope/zope-container
	net-zope/zope-event
	net-zope/zope-lifecycleevent"
DEPEND="${RDEPEND}
	app-arch/unzip
	dev-python/setuptools"

S="${WORKDIR}/${MY_P}"

DOCS="CHANGES.txt README.txt"
PYTHON_MODNAME="${MY_PN/.//}"
