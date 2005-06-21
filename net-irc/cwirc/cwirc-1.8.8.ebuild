# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/cwirc/cwirc-1.8.8.ebuild,v 1.4 2005/06/21 13:27:02 swegener Exp $

inherit eutils toolchain-funcs

DESCRIPTION="An X-chat plugin for sending and receiving raw morse code over IRC"
HOMEPAGE="http://webperso.easyconnect.fr/om.the/web/cwirc/"
SRC_URI="http://webperso.easyconnect.fr/om.the/web/cwirc/download/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE=""

RDEPEND="x11-libs/gtk+
	|| (
		>=net-irc/xchat-2.0.1
		>=net-irc/xchat-gnome-0.4
	)"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/cwirc-1.7.1-gentoo.patch
	sed -i -e 's:$(STRIP):true:' Makefile
}

src_compile() {
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS} -DLINUX" || die "emake failed"
}

src_install() {
	einstall || die "einstall failed"

	dodoc README RELEASE_NOTES Changelog
	docinto schematics
	dodoc schematics/*
}
