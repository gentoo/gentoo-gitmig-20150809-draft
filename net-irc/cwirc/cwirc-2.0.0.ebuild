# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/cwirc/cwirc-2.0.0.ebuild,v 1.4 2009/04/30 21:17:35 patrick Exp $

inherit eutils toolchain-funcs

DESCRIPTION="An X-chat plugin for sending and receiving raw morse code over IRC"
HOMEPAGE="http://myspace.voo.be/pcoupard/cwirc/"
SRC_URI="http://myspace.voo.be/pcoupard/cwirc/download/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

RDEPEND="x11-libs/gtk+
	>=net-irc/xchat-2.0.1"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/cwirc-1.7.1-gentoo.patch
}

src_compile() {
	emake STRIP="true" CC="$(tc-getCC)" CFLAGS="${CFLAGS} -DLINUX" || die "emake failed"
}

src_install() {
	make install || die "make install failed"

	dodoc README RELEASE_NOTES Changelog
	docinto schematics
	dodoc schematics/*
}
