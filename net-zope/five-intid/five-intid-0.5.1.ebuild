# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/five-intid/five-intid-0.5.1.ebuild,v 1.1 2010/11/08 15:50:25 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2:2.6"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.4 2.5 3.*"

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

src_prepare() {
	distutils_src_prepare

	# http://dev.plone.org/collective/changeset/226233/
	sed -e "/zope.app.zapi/d" -i setup.py
	sed \
		-e "s/from zope.app import zapi/from zope.component import getAllUtilitiesRegisteredFor/" \
		-e "s/zapi.getAllUtilitiesRegisteredFor/getAllUtilitiesRegisteredFor/" \
		-i five/intid/intid.py
}
