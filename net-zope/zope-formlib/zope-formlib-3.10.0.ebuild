# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/zope-formlib/zope-formlib-3.10.0.ebuild,v 1.1 2009/12/24 17:02:19 arfrever Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

MY_PN="${PN/-/.}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Form generation and validation library for Zope"
HOMEPAGE="http://pypi.python.org/pypi/zope.formlib"
SRC_URI="http://pypi.python.org/packages/source/${MY_PN:0:1}/${MY_PN}/${MY_P}.zip"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="dev-python/pytz
	net-zope/zope-app-form
	net-zope/zope-browser
	net-zope/zope-browserpage
	net-zope/zope-component
	net-zope/zope-event
	net-zope/zope-i18n
	net-zope/zope-i18nmessageid
	net-zope/zope-interface
	net-zope/zope-lifecycleevent
	net-zope/zope-publisher
	net-zope/zope-schema
	net-zope/zope-security"
DEPEND="${RDEPEND}
	app-arch/unzip
	dev-python/setuptools"
RESTRICT_PYTHON_ABIS="3.*"

S="${WORKDIR}/${MY_P}"

PYTHON_MODNAME="${PN/-//}"
DOCS="CHANGES.txt README.txt"
