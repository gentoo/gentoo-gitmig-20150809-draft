# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/groups/groups-0.8.ebuild,v 1.1 2010/11/08 14:07:11 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2:2.6"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.4 2.5 3.*"

inherit distutils

MY_PN="Products.Groups"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Group support for Zope 2"
HOMEPAGE="http://infrae.com/download/silva_all/Groups"
SRC_URI="${HOMEPAGE}/${PV}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="net-zope/accesscontrol
	>=net-zope/zope-2.12"
DEPEND="${RDEPEND}
	dev-python/setuptools"

S="${WORKDIR}/${MY_P}"

DOCS="Products/Groups/CREDITS.txt Products/Groups/HISTORY.txt Products/Groups/README.txt"
PYTHON_MODNAME="${MY_PN/.//}"
