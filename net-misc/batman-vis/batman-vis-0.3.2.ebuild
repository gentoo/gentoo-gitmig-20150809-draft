# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/batman-vis/batman-vis-0.3.2.ebuild,v 1.1 2011/05/20 23:37:58 xmw Exp $

EAPI=3

inherit toolchain-funcs

DESCRIPTION="BATMAN visualization server for the net-misc/batmand server"
HOMEPAGE="http://www.open-mesh.org/"
MY_P=${P/batman-/}
SRC_URI="http://downloads.open-mesh.org/batman/releases/batman-${PV}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

S=${WORKDIR}/${MY_P}

src_prepare() {
	sed -e "/^CFLAGS/s: -O.* : :" \
		-e "/^CFLAGS/s: -g.* : :" \
		-e "/^NUM_CPUS/d" \
		-e "/\$(MAKE)/s: -j \$(NUM_CPUS) : :" \
		-e "/BINARY_NAME=/s:vis:${PN}:" \
		-i Makefile || die
}

src_compile() {
	emake CC="$(tc-getCC)" Q_CC="" Q_LD="" || die
}

src_install() {
	emake INSTALL_PREFIX="${D}" install || die

	newinitd "${FILESDIR}"/${PN}-init.d ${PN} || die
	newconfd "${FILESDIR}"/${PN}-conf.d ${PN} || die

	dodoc README || die
}
