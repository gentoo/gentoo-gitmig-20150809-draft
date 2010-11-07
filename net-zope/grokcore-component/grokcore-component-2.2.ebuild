# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/grokcore-component/grokcore-component-2.2.ebuild,v 1.1 2010/11/07 20:11:58 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

MY_PN="${PN/-/.}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Grok-like configuration for basic components (adapters, utilities, subscribers)"
HOMEPAGE="http://grok.zope.org/ http://pypi.python.org/pypi/grokcore.component"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND=">=dev-python/martian-0.14
	net-zope/zope-component
	net-zope/zope-configuration
	net-zope/zope-interface
	net-zope/zope-schema
	net-zope/zope-testing"
DEPEND="${RDEPEND}
	dev-python/setuptools"

S="${WORKDIR}/${MY_P}"

DOCS="CHANGES.txt README.txt"
PYTHON_MODNAME="${PN/-//}"
