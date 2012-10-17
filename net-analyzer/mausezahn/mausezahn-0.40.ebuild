# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/mausezahn/mausezahn-0.40.ebuild,v 1.1 2012/10/17 16:57:26 pinkbyte Exp $

EAPI=4

MY_P="mz-${PV}"

inherit cmake-utils

DESCRIPTION="Fast traffic generator written in C, allows to send nearly every possible and impossible packet"
HOMEPAGE="http://www.perihel.at/sec/mz/index.html"
SRC_URI="http://www.perihel.at/sec/mz/${MY_P}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="dev-libs/libcli
	net-libs/libnet:1.1
	net-libs/libpcap"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	# respect CFLAGS
	sed -i -e '/CMAKE_C_FLAGS/d' CMakeLists.txt || die 'sed on CMAKE_C_FLAGS failed'
}

pkg_postinst() {
	elog "Documentation on how to use ${PN} can be found at ${HOMEPAGE}"
}
