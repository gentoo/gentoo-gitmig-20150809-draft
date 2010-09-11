# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/five-formlib/five-formlib-1.0.3.ebuild,v 1.2 2010/09/11 21:15:51 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

MY_PN="${PN/-/.}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="zope.formlib integration for Zope 2"
HOMEPAGE="http://pypi.python.org/pypi/five.formlib"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.zip"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~sparc ~x86"
IUSE=""

RDEPEND="net-zope/accesscontrol
	net-zope/extensionclass
	net-zope/transaction
	net-zope/zope-app-form
	net-zope/zope-browser
	|| ( net-zope/zope-browsermenu net-zope/zope-app-publisher )
	net-zope/zope-component
	net-zope/zope-event
	net-zope/zope-formlib
	net-zope/zope-i18nmessageid
	net-zope/zope-interface
	net-zope/zope-lifecycleevent
	net-zope/zope-location
	net-zope/zope-publisher
	net-zope/zope-schema"
DEPEND="${RDEPEND}
	app-arch/unzip
	dev-python/setuptools"

S="${WORKDIR}/${MY_P}"

DOCS="CHANGES.txt README.txt"
PYTHON_MODNAME="${PN/-//}"
