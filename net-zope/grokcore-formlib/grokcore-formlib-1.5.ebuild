# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/grokcore-formlib/grokcore-formlib-1.5.ebuild,v 1.1 2010/09/19 23:56:56 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

MY_PN="${PN/-/.}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Grok-like configuration for zope.formlib components"
HOMEPAGE="http://grok.zope.org/ http://pypi.python.org/pypi/grokcore.formlib"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="dev-python/martian
	dev-python/pytz
	net-zope/grokcore-component
	net-zope/grokcore-security
	net-zope/grokcore-view
	net-zope/zope-container
	net-zope/zope-event
	net-zope/zope-formlib
	net-zope/zope-interface
	net-zope/zope-lifecycleevent
	net-zope/zope-publisher
	net-zope/zope-schema"
DEPEND="${RDEPEND}
	dev-python/setuptools"

S="${WORKDIR}/${MY_P}"

DOCS="CHANGES.txt README.txt"
PYTHON_MODNAME="${PN/-//}"
