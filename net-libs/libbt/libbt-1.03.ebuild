# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libbt/libbt-1.03.ebuild,v 1.1 2004/07/15 08:20:33 squinky86 Exp $

inherit eutils

DESCRIPTION="libBT is an impementation of the BitTorrent core protocols in C"
HOMEPAGE="http://libbt.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
RESTRICT="nomirror"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"

IUSE=""

DEPEND="dev-libs/openssl
	net-misc/curl
	sys-fs/e2fsprogs"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-headerfix.patch
}

src_compile () {
	econf || die
	sed -i -e "s:-g -Wall:${CFLAGS} -g -Wall:g" src/Makefile
	emake || die
}

src_install () {
	dobin src/btlist src/btget src/btcheck
	doman man/*
	insinto /usr/include/libbt
	doins include/*
	dolib src/libbt.a
	dodoc CHANGELOG COPYING CREDITS README docs/*
}
