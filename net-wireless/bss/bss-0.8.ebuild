# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/bss/bss-0.8.ebuild,v 1.1 2009/05/10 10:45:53 nirbheek Exp $

inherit toolchain-funcs

DESCRIPTION="Bluetooth stack smasher / fuzzer"
HOMEPAGE="http://securitech.homeunix.org/blue/"
SRC_URI="http://securitech.homeunix.org/blue/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~ppc"
IUSE=""

RDEPEND="|| ( net-wireless/bluez
	net-wireless/bluez-libs )"
DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}
	sed -i.orig \
		-e 's!/local!!g' \
		"${S}"/Makefile
}

src_compile() {
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}" BSS_FLAGS="${LDFLAGS}" || die "emake failed"
}

src_install() {
	dosbin bss
	dodoc AUTHOR BUGS CHANGELOG CONTRIB NOTES README TODO
	dodoc "${S}"/replay_packet/replay_l2cap_packet.c
}
