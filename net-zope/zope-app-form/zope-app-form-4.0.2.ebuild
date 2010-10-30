# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/zope-app-form/zope-app-form-4.0.2.ebuild,v 1.2 2010/10/30 18:52:55 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

MY_PN="${PN//-/.}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="The Original Zope 3 Form Framework"
HOMEPAGE="http://pypi.python.org/pypi/zope.app.form"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND="net-zope/transaction
	net-zope/zope-browser
	net-zope/zope-browsermenu
	net-zope/zope-browserpage
	net-zope/zope-component
	net-zope/zope-configuration
	net-zope/zope-datetime
	net-zope/zope-event
	net-zope/zope-exceptions
	>=net-zope/zope-formlib-4.0
	net-zope/zope-i18n
	net-zope/zope-interface
	net-zope/zope-lifecycleevent
	net-zope/zope-proxy
	net-zope/zope-publisher
	net-zope/zope-schema
	net-zope/zope-security"
DEPEND="${RDEPEND}
	dev-python/setuptools"
RESTRICT_PYTHON_ABIS="3.*"

S="${WORKDIR}/${MY_P}"

PYTHON_MODNAME="${PN//-//}"
DOCS="CHANGES.txt README.txt"
