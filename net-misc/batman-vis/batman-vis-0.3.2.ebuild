# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/batman-vis/batman-vis-0.3.2.ebuild,v 1.2 2011/05/22 23:32:08 xmw Exp $

EAPI=3

inherit toolchain-funcs

DESCRIPTION="BATMAN visualization server for the net-misc/batmand server"
HOMEPAGE="http://www.open-mesh.org/"
MY_P=${P/batman-/}
SRC_URI="
http://downloads.open-mesh.org/batman/stable/sources/${PN/batman-/}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

S=${WORKDIR}/${MY_P}

src_prepare() {
	sed -e "/^CFLAGS/s: -O[^[:space:]]* : :" \
		-e "/^CFLAGS/s: -g[^[:space:]]* : :" \
		-e "s: -j \$(NUM_CPUS) : :" \
		-i Makefile || die
}

src_compile() {
	emake CC="$(tc-getCC)" V=1 BINARY_NAME=${PN} || die
}

src_install() {
	emake INSTALL_PREFIX="${D}" BINARY_NAME=${PN} install || die

	newinitd "${FILESDIR}"/${PN}-init.d ${PN} || die
	newconfd "${FILESDIR}"/${PN}-conf.d ${PN} || die

	dodoc README || die
}
