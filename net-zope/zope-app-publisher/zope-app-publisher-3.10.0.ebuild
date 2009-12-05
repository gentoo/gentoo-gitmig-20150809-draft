# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/zope-app-publisher/zope-app-publisher-3.10.0.ebuild,v 1.1 2009/12/05 02:28:34 arfrever Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

MY_PN="${PN//-/.}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Implementations and means for configuration of Zope 3-style views and resources."
HOMEPAGE="http://pypi.python.org/pypi/zope.app.publisher"
SRC_URI="http://pypi.python.org/packages/source/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="net-zope/zope-browsermenu
	net-zope/zope-browserpage
	net-zope/zope-browserresource
	net-zope/zope-component
	net-zope/zope-configuration
	net-zope/zope-componentvocabulary
	net-zope/zope-datetime
	net-zope/zope-i18nmessageid
	net-zope/zope-interface
	net-zope/zope-location
	net-zope/zope-ptresource
	net-zope/zope-publisher
	net-zope/zope-schema
	net-zope/zope-security"
DEPEND="${RDEPEND}
	dev-python/setuptools"
RESTRICT_PYTHON_ABIS="3.*"

S="${WORKDIR}/${MY_P}"

PYTHON_MODNAME="${PN//-//}"
DOCS="CHANGES.txt README.txt"
