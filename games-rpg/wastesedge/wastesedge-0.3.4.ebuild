# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-rpg/wastesedge/wastesedge-0.3.4.ebuild,v 1.4 2006/07/03 19:54:43 mr_bones_ Exp $

inherit eutils games

DESCRIPTION="role playing game to showcase the adonthell engine"
HOMEPAGE="http://adonthell.linuxgames.com/"
SRC_URI="http://savannah.nongnu.org/download/adonthell/${PN}-src-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE="vorbis doc nls"
RESTRICT="nouserpriv"

RDEPEND=">=dev-lang/python-2.0
	>=games-rpg/adonthell-0.3.3"
DEPEND="${RDEPEND}
	doc? ( >=app-doc/doxygen-1.2 )"

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
