# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/zope-app-publication/zope-app-publication-3.13.0.ebuild,v 1.1 2011/01/25 22:26:56 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"

inherit distutils

MY_PN="${PN//-/.}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Zope publication"
HOMEPAGE="http://pypi.python.org/pypi/zope.app.publication"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND="net-zope/zodb
	net-zope/zope-authentication
	net-zope/zope-browser
	net-zope/zope-component
	net-zope/zope-configuration
	net-zope/zope-error
	net-zope/zope-event
	net-zope/zope-interface
	net-zope/zope-location
	>=net-zope/zope-publisher-3.12.4
	net-zope/zope-security
	net-zope/zope-schema
	net-zope/zope-testing
	>=net-zope/zope-traversing-3.9.0"
DEPEND="${RDEPEND}
	dev-python/setuptools"

S="${WORKDIR}/${MY_P}"

DOCS="CHANGES.txt README.txt"
PYTHON_MODNAME="${PN//-//}"
