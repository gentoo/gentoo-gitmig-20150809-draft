# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-rpg/wastesedge/wastesedge-0.3.3.ebuild,v 1.6 2004/04/10 09:06:49 mr_bones_ Exp $

inherit games

DESCRIPTION="role playing game to showcase the adonthell engine"
HOMEPAGE="http://adonthell.linuxgames.com/"
SRC_URI="http://savannah.nongnu.org/download/adonthell/src/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"
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
		`use_enable nls` \
		`use_enable doc` \
		--with-adonthell-binary=${GAMES_BINDIR}/adonthell \
		|| die
	emake || die "emake failed"
}

src_install(){
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS PLAYING README
	prepgamesdirs
}
