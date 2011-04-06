# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/infrae-rest/infrae-rest-1.0.1.ebuild,v 1.2 2011/04/06 13:36:19 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2:2.6"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.4 2.5 3.* *-jython"

inherit distutils

MY_PN="${PN/-/.}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="infrae.rest allows to define a REST API to access and manage Silva content"
HOMEPAGE="http://pypi.python.org/pypi/infrae.rest"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="dev-python/martian
	dev-python/simplejson
	net-zope/five-grok
	net-zope/zope-component
	net-zope/zope-interface
	net-zope/zope-publisher
	net-zope/zope-traversing"
DEPEND="${RDEPEND}
	dev-python/setuptools"

S="${WORKDIR}/${MY_P}"

DOCS="docs/HISTORY.txt README.txt"
PYTHON_MODNAME="${PN/-//}"
