# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/zope-app-pagetemplate/zope-app-pagetemplate-3.10.1.ebuild,v 1.2 2010/01/22 19:12:24 ranger Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

MY_PN="${PN//-/.}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="PageTemplate integration for Zope 3"
HOMEPAGE="http://pypi.python.org/pypi/zope.app.pagetemplate"
SRC_URI="http://pypi.python.org/packages/source/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="~amd64 ~ppc"
IUSE=""

RDEPEND="net-zope/zope-browserpage
	net-zope/zope-configuration
	net-zope/zope-dublincore
	net-zope/zope-i18nmessageid
	net-zope/zope-interface
	net-zope/zope-pagetemplate
	net-zope/zope-schema
	net-zope/zope-security
	net-zope/zope-size
	net-zope/zope-tales
	net-zope/zope-traversing"
DEPEND="${RDEPEND}
	dev-python/setuptools"
RESTRICT_PYTHON_ABIS="3.*"

S="${WORKDIR}/${MY_P}"

PYTHON_MODNAME="${PN//-//}"
DOCS="CHANGES.txt README.txt"
