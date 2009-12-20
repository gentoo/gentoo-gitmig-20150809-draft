# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/zope-app-publication/zope-app-publication-3.10.0.ebuild,v 1.1 2009/12/20 02:44:46 arfrever Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

MY_PN="${PN//-/.}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Zope publication"
HOMEPAGE="http://pypi.python.org/pypi/zope.app.publication"
SRC_URI="http://pypi.python.org/packages/source/${MY_PN:0:1}/${MY_PN}/${MY_P}.zip"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="~amd64"
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
	>=net-zope/zope-publisher-3.11.0
	net-zope/zope-security
	net-zope/zope-schema
	net-zope/zope-testing
	>=net-zope/zope-traversing-3.9.0"
DEPEND="${RDEPEND}
	app-arch/unzip
	dev-python/setuptools"
RESTRICT_PYTHON_ABIS="3.*"

S="${WORKDIR}/${MY_P}"

PYTHON_MODNAME="${PN//-//}"
DOCS="CHANGES.txt README.txt"
