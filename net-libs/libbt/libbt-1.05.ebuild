# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libbt/libbt-1.05.ebuild,v 1.1 2006/01/13 13:32:57 mkay Exp $

inherit eutils

DESCRIPTION="libBT is an implementation of the BitTorrent core protocols in C"
HOMEPAGE="http://libbt.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
RESTRICT="nomirror"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~amd64"

IUSE=""

DEPEND="dev-libs/openssl
	net-misc/curl
	sys-fs/e2fsprogs"

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
