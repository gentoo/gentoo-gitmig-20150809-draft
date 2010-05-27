# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/zope-i18n/zope-i18n-3.7.3.ebuild,v 1.1 2010/05/27 18:17:19 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

MY_PN="${PN/-/.}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Zope3 Internationalization Support"
HOMEPAGE="http://pypi.python.org/pypi/zope.i18n"
SRC_URI="http://pypi.python.org/packages/source/${MY_PN:0:1}/${MY_PN}/${MY_P}.zip"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND="dev-python/pytz
	net-zope/zope-component
	net-zope/zope-configuration
	net-zope/zope-i18nmessageid
	net-zope/zope-interface
	net-zope/zope-schema"
DEPEND="${RDEPEND}
	app-arch/unzip
	dev-python/setuptools"
RESTRICT_PYTHON_ABIS="3.*"

S="${WORKDIR}/${MY_P}"

DOCS="CHANGES.txt README.txt"
PYTHON_MODNAME="${PN/-//}"
