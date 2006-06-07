# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/bss/bss-0.6.ebuild,v 1.1 2006/06/07 04:28:21 robbat2 Exp $

inherit toolchain-funcs

DESCRIPTION="Bluetooth stack smasher / fuzzer"
HOMEPAGE="http://www.secuobs.com/news/05022006-bluetooth10.shtml"
SRC_URI="http://www.secuobs.com/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""

DEPEND="net-wireless/bluez-libs"

src_unpack() {
	unpack ${A}
	sed -i.orig \
		-e 's!/local!!g' \
		${S}/Makefile
}

src_compile() {
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}" BSS_FLAGS="${LDFLAGS}" || die "emake failed"
}

src_install() {
	dosbin bss
	dodoc AUTHOR BUGS CONTRIB README TODO VERSION
	dodoc doc/*
	dodoc ${S}/replay_packet/replay_l2cap_packet.c
}
