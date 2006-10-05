# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/toppler/toppler-1.1.1.ebuild,v 1.2 2006/10/05 18:21:41 nyhm Exp $

inherit games

DESCRIPTION="Reimplementation of Nebulous using SDL"
HOMEPAGE="http://toppler.sourceforge.net/"
SRC_URI="mirror://sourceforge/toppler/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="nls"

RDEPEND="media-libs/libsdl
	media-libs/sdl-mixer
	nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

src_compile() {
	egamesconf $(use_enable nls) || die
	emake || die "emake failed"
}

src_install() {
	make \
		DESTDIR="${D}" \
		localedir="/usr/share/locale" \
		install || die "make install failed"
	dodoc AUTHORS ChangeLog README
	prepgamesdirs
}
