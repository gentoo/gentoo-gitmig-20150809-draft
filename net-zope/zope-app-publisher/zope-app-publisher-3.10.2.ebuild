# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/zope-app-publisher/zope-app-publisher-3.10.2.ebuild,v 1.1 2010/09/17 15:07:22 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

MY_PN="${PN//-/.}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Implementations and means for configuration of Zope 3-style views and resources."
HOMEPAGE="http://pypi.python.org/pypi/zope.app.publisher"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.zip"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
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
	>=net-zope/zope-publisher-3.12
	net-zope/zope-schema
	net-zope/zope-security"
DEPEND="${RDEPEND}
	app-arch/unzip
	dev-python/setuptools"

S="${WORKDIR}/${MY_P}"

DOCS="CHANGES.txt README.txt"
PYTHON_MODNAME="${PN//-//}"
