# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/zope-app-container/zope-app-container-3.9.1.ebuild,v 1.2 2010/12/05 18:48:14 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"

inherit distutils

MY_PN="${PN//-/.}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Zope Container"
HOMEPAGE="http://pypi.python.org/pypi/zope.app.container"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.zip"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc"
IUSE=""

RDEPEND="net-zope/zope-annotation
	net-zope/zope-app-pagetemplate
	net-zope/zope-app-publisher
	net-zope/zope-browser
	net-zope/zope-component
	net-zope/zope-configuration
	net-zope/zope-container
	net-zope/zope-copypastemove
	net-zope/zope-dublincore
	net-zope/zope-event
	net-zope/zope-exceptions
	net-zope/zope-i18n
	net-zope/zope-i18nmessageid
	net-zope/zope-interface
	net-zope/zope-lifecycleevent
	net-zope/zope-location
	net-zope/zope-publisher
	net-zope/zope-schema
	net-zope/zope-security
	net-zope/zope-size
	net-zope/zope-traversing"
DEPEND="${RDEPEND}
	app-arch/unzip
	dev-python/setuptools"

S="${WORKDIR}/${MY_P}"

DOCS="CHANGES.txt README.txt"
PYTHON_MODNAME="${PN//-//}"
