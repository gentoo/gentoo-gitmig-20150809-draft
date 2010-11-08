# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/five-grok/five-grok-1.1.2.ebuild,v 1.1 2010/11/08 14:17:43 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2:2.6"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.4 2.5 3.*"

inherit distutils

MY_PN="${PN/-/.}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Grok-like layer for Zope 2"
HOMEPAGE="http://pypi.python.org/pypi/five.grok"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.zip"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="dev-python/martian
	net-zope/accesscontrol
	net-zope/acquisition
	net-zope/five-localsitemanager
	net-zope/grokcore-annotation
	net-zope/grokcore-component
	net-zope/grokcore-formlib
	net-zope/grokcore-security
	net-zope/grokcore-site
	net-zope/grokcore-view
	net-zope/grokcore-viewlet
	>=net-zope/zope-2.12
	net-zope/zope-annotation
	net-zope/zope-app-container
	net-zope/zope-app-pagetemplate
	net-zope/zope-component
	net-zope/zope-formlib
	net-zope/zope-interface
	net-zope/zope-pagetemplate
	net-zope/zope-location
	net-zope/zope-publisher
	net-zope/zope-traversing"
DEPEND="${RDEPEND}
	app-arch/unzip
	dev-python/setuptools"

S="${WORKDIR}/${MY_P}"

DOCS="docs/CREDITS.txt docs/HISTORY.txt README.txt"
PYTHON_MODNAME="${PN/-//}"
