# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/xbubble/xbubble-0.5.8.ebuild,v 1.4 2004/11/22 13:57:26 sekretarz Exp $

inherit games

DESCRIPTION="a Puzzle Bobble clone similar to Frozen-Bubble"
HOMEPAGE="http://www.nongnu.org/xbubble"
SRC_URI="http://www.ibiblio.org/pub/mirrors/gnu/ftp/savannah/files/xbubble/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc ~amd64"
IUSE="nls"

DEPEND="virtual/x11
	media-libs/libpng"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e "/^AM_CFLAGS/d" src/Makefile.in \
		|| die "sed failed"
}

src_compile() {
	egamesconf \
		--disable-dependency-tracking \
		$(use_enable nls) \
		|| die
	emake \
		localedir="/usr/share/locale" \
		|| die "emake failed"
}

src_install() {
	make DESTDIR="${D}" \
		localedir="/usr/share/locale" \
		install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS NetworkProtocol README TODO
	prepgamesdirs
}
