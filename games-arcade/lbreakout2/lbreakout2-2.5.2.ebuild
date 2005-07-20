# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/lbreakout2/lbreakout2-2.5.2.ebuild,v 1.3 2005/07/20 19:53:07 mr_bones_ Exp $

inherit flag-o-matic eutils games

DESCRIPTION="Breakout clone written with the SDL library"
HOMEPAGE="http://lgames.sourceforge.net/index.php?project=LBreakout2"
SRC_URI="mirror://sourceforge/lgames/${P}.tar.gz
	mirror://gentoo/lbreakout2-levelsets-20040319.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ppc x86"
IUSE=""

DEPEND="media-libs/libpng
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
	make install DESTDIR="${D}" || die "make install failed"

	mv "${D}"/usr/share/doc/${PF}/{lbreakout2,html}
	dodoc AUTHORS README TODO ChangeLog

	newicon client/gfx/win_icon.png lbreakout2.png
	make_desktop_entry lbreakout2 LBreakout2

	prepgamesdirs
}
