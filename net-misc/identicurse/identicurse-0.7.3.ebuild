# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/identicurse/identicurse-0.7.3.ebuild,v 1.1 2011/09/03 19:51:44 xarthisius Exp $

EAPI=3

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils versionator

MY_PV=$(get_version_component_range 1-2)

DESCRIPTION="A simple Identi.ca client with a curses-based UI"
HOMEPAGE="http://identicurse.net"
SRC_URI="http://identicurse.net/release/${MY_PV}/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/setuptools"
RDEPEND=""

S=${WORKDIR}/${PN}-${MY_PV}

src_prepare() {
	epatch "${FILESDIR}"/${PN}-gzipped_readme.patch \
		"${FILESDIR}"/${PN}-config_json_path.patch
	distutils_src_prepare
}
