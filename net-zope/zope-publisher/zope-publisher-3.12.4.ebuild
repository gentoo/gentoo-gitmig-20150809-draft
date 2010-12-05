# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/zope-publisher/zope-publisher-3.12.4.ebuild,v 1.3 2010/12/05 18:59:42 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"

inherit distutils

MY_PN="${PN/-/.}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="The Zope publisher publishes Python objects on the web."
HOMEPAGE="http://pypi.python.org/pypi/zope.publisher"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND="dev-python/setuptools
	net-zope/zope-browser
	net-zope/zope-component
	net-zope/zope-configuration
	net-zope/zope-contenttype
	net-zope/zope-event
	net-zope/zope-exceptions
	net-zope/zope-i18n
	net-zope/zope-interface
	net-zope/zope-location
	net-zope/zope-proxy
	net-zope/zope-schema
	net-zope/zope-security"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${MY_P}"

DOCS="CHANGES.txt README.txt"
PYTHON_MODNAME="${PN/-//}"
