# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-rpg/wastesedge/wastesedge-0.3.3.ebuild,v 1.3 2004/02/11 15:07:54 dholm Exp $

inherit games

DESCRIPTION="role playing game to showcase the adonthell engine"
SRC_URI="http://savannah.nongnu.org/download/adonthell/src/${P}.tar.gz"
HOMEPAGE="http://adonthell.linuxgames.com/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc"
IUSE="oggvorbis doc nls"

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
	emake || die
}

src_install(){
	emake install DESTDIR=${D} || die
	dodoc AUTHORS ChangeLog NEWS PLAYING README
	prepgamesdirs
}
