# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/zope-container/zope-container-3.9.1.ebuild,v 1.1 2009/11/22 01:47:46 arfrever Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

MY_PN="${PN/-/.}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Zope Container"
HOMEPAGE="http://pypi.python.org/pypi/zope.container"
SRC_URI="http://pypi.python.org/packages/source/${MY_PN:0:1}/${MY_PN}/${MY_P}.zip"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="net-zope/zodb
	net-zope/zope-app-dependable
	net-zope/zope-broken
	net-zope/zope-cachedescriptors
	net-zope/zope-component
	net-zope/zope-dottedname
	net-zope/zope-event
	net-zope/zope-filerepresentation
	net-zope/zope-i18nmessageid
	net-zope/zope-interface
	net-zope/zope-lifecycleevent
	net-zope/zope-location
	net-zope/zope-publisher
	net-zope/zope-schema
	net-zope/zope-security
	net-zope/zope-size
	net-zope/zope-traversing"
DEPEND="${RDEPEND}
	app-arch/unzip
	dev-python/setuptools"
RESTRICT_PYTHON_ABIS="3.*"

S="${WORKDIR}/${MY_P}"

PYTHON_MODNAME="${PN/-//}"
DOCS="CHANGES.txt README.txt"

src_install() {
	distutils_src_install

	# Don't install sources.
	find "${D}"usr/$(get_libdir)/python*/site-packages -name "*.c" | xargs rm -f
}
