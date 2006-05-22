# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/cwirc/cwirc-2.0.0.ebuild,v 1.1 2006/05/22 17:45:25 swegener Exp $

inherit eutils toolchain-funcs

DESCRIPTION="An X-chat plugin for sending and receiving raw morse code over IRC"
HOMEPAGE="http://users.skynet.be/ppc/cwirc/"
SRC_URI="http://users.skynet.be/ppc/cwirc/download/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""

RDEPEND="x11-libs/gtk+
	>=net-irc/xchat-2.0.1"

DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

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
