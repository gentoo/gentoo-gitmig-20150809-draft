# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-rpg/wastesedge/wastesedge-0.3.3.ebuild,v 1.10 2005/03/14 05:17:05 mr_bones_ Exp $

inherit eutils games

DESCRIPTION="role playing game to showcase the adonthell engine"
HOMEPAGE="http://adonthell.linuxgames.com/"
SRC_URI="http://savannah.nongnu.org/download/adonthell/src/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE="oggvorbis doc nls"
RESTRICT="nouserpriv"

DEPEND="virtual/x11
	>=media-libs/libsdl-1.1.6
	>=dev-lang/python-2.0
	oggvorbis? ( >=media-libs/libvorbis-1.0
		>=media-libs/libogg-1.0 )
	doc? ( >=app-doc/doxygen-1.2 )
	>=games-rpg/adonthell-${PV}"

src_compile(){
	egamesconf \
		--disable-dependency-tracking \
		$(use_enable nls) \
		$(use_enable doc) \
		--with-adonthell-binary="${GAMES_BINDIR}/adonthell" \
		|| die
	emake || die "emake failed"
}

src_install(){
	make DESTDIR="${D}" pixmapdir=/usr/share/pixmaps install \
		|| die "make install failed"
	dodoc AUTHORS ChangeLog NEWS PLAYING README
	make_desktop_entry adonthell-wastesedge "Waste's Edge" wastesedge_32x32.xpm
	prepgamesdirs
}
