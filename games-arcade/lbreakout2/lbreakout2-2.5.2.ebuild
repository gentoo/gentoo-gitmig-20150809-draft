# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/lbreakout2/lbreakout2-2.5.2.ebuild,v 1.2 2005/03/30 19:40:08 kloeri Exp $

inherit flag-o-matic games

DESCRIPTION="Breakout clone written with the SDL library"
HOMEPAGE="http://lgames.sourceforge.net/index.php?project=LBreakout2"
SRC_URI="mirror://sourceforge/lgames/${P}.tar.gz
	mirror://gentoo/lbreakout2-levelsets-20040319.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86 ~alpha"
IUSE=""

DEPEND="virtual/libc
	media-libs/libpng
	sys-libs/zlib
	>=media-libs/libsdl-1.1.5
	media-libs/sdl-net
	media-libs/sdl-mixer"

src_unpack() {
	unpack ${P}.tar.gz
	mkdir "${S}/levels"
	cd "${S}/levels"
	unpack lbreakout2-levelsets-20040319.tar.gz
}

src_compile() {
	filter-flags -O?
	egamesconf \
		--enable-sdl-net \
		--with-docdir="/usr/share/doc/${PF}" \
		|| die
	emake || die "emake failed"
}

src_install() {
	make install DESTDIR="${D}" || die

	mv "${D}"/usr/share/doc/${PF}/{lbreakout2,html}
	dodoc AUTHORS README TODO ChangeLog

	cp lbreakout48.gif lbreakout2.gif
	doicon lbreakout2.gif
	make_desktop_entry lbreakout2 LBreakout2 lbreakout2.gif

	prepgamesdirs
}
