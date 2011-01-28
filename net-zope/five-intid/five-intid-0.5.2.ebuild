# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/five-intid/five-intid-0.5.2.ebuild,v 1.1 2011/01/28 23:42:01 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2:2.6"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.4 2.5 3.* *-jython"

inherit distutils

MY_PN="${PN/-/.}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Zope2 support for zope.intid"
HOMEPAGE="http://pypi.python.org/pypi/five.intid"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.zip"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="net-zope/acquisition
	net-zope/five-localsitemanager
	net-zope/zexceptions
	net-zope/zodb
	net-zope/zope-app-intid
	net-zope/zope-component
	net-zope/zope-event
	net-zope/zope-interface
	net-zope/zope-intid
	net-zope/zope-keyreference
	net-zope/zope-lifecycleevent
	net-zope/zope-location
	net-zope/zope-site"
DEPEND="${RDEPEND}
	app-arch/unzip
	dev-python/setuptools"

S="${WORKDIR}/${MY_P}"

DOCS="docs/HISTORY.txt README.txt"
PYTHON_MODNAME="${PN/-//}"
