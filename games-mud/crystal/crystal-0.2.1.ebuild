# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-mud/crystal/crystal-0.2.1.ebuild,v 1.2 2004/06/24 22:59:37 agriffis Exp $

inherit games

DESCRIPTION="The crystal MUD client"
HOMEPAGE="http://www.evilmagic.org/crystal/"
SRC_URI="http://www.evilmagic.org/dist/${P}.tar.gz"

KEYWORDS="x86"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND="virtual/glibc
	sys-libs/zlib
	sys-libs/ncurses
	dev-libs/openssl"

src_compile() {
	egamesconf \
		--disable-scripting || die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS NEWS README TODO || die "dodoc failed"
	prepgamesdirs
}
