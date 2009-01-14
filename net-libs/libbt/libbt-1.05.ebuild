# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libbt/libbt-1.05.ebuild,v 1.4 2009/01/14 05:20:07 vapier Exp $

inherit eutils

DESCRIPTION="implementation of the BitTorrent core protocols in C"
HOMEPAGE="http://libbt.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

DEPEND="dev-libs/openssl
	net-misc/curl
	sys-fs/e2fsprogs"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-build.patch #248034
	epatch "${FILESDIR}"/${PV}-btlist.patch # 152489
	sed -i -e '/CFLAGS/s|:=|+=|' src/Makefile.in || die
}

src_install() {
	dobin src/btlist src/btget src/btcheck || die
	doman man/*
	insinto /usr/include/libbt
	doins include/*
	dolib src/libbt.a
	dodoc CHANGELOG CREDITS README docs/*
}
