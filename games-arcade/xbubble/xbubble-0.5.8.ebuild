# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/xbubble/xbubble-0.5.8.ebuild,v 1.5 2005/05/15 18:48:18 vapier Exp $

inherit games

DESCRIPTION="a Puzzle Bobble clone similar to Frozen-Bubble"
HOMEPAGE="http://www.nongnu.org/xbubble/"
SRC_URI="http://www.ibiblio.org/pub/mirrors/gnu/ftp/savannah/files/xbubble/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE="nls"

DEPEND="virtual/x11
	media-libs/libpng"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e '/^AM_CFLAGS/d' \
		src/Makefile.in || die "sed cflags"
	sed -i \
		-e '/^localedir/s:=.*:=/usr/share/locale:' \
		configure po/Makefile.in.in || die "sed locale"
}

src_compile() {
	egamesconf \
		--disable-dependency-tracking \
		$(use_enable nls) \
		|| die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS NetworkProtocol README TODO
	prepgamesdirs
}
