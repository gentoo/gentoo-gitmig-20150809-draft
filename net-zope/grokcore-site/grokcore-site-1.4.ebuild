# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/grokcore-site/grokcore-site-1.4.ebuild,v 1.2 2010/11/29 02:00:26 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"

inherit distutils

MY_PN="${PN/-/.}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Grok-like configuration for Zope local site and utilities"
HOMEPAGE="http://grok.zope.org/ http://pypi.python.org/pypi/grokcore.site"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND=">=dev-python/martian-0.13
	>=net-zope/grokcore-component-2.1
	net-zope/zodb
	net-zope/zope-annotation
	net-zope/zope-component
	net-zope/zope-container
	net-zope/zope-interface
	net-zope/zope-lifecycleevent
	net-zope/zope-site"
DEPEND="${RDEPEND}
	dev-python/setuptools"

S="${WORKDIR}/${MY_P}"

DOCS="CHANGES.txt README.txt"
PYTHON_MODNAME="${PN/-//}"
