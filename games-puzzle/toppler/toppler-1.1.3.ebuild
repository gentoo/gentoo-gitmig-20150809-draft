# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/toppler/toppler-1.1.3.ebuild,v 1.5 2009/02/06 22:31:48 mr_bones_ Exp $

EAPI=2
inherit games

DESCRIPTION="Reimplementation of Nebulous using SDL"
HOMEPAGE="http://toppler.sourceforge.net/"
SRC_URI="mirror://sourceforge/toppler/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="nls"

RDEPEND="media-libs/libsdl
	media-libs/sdl-mixer[vorbis]
	nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

S=${WORKDIR}/${P/a/}
PATCHES=( "${FILESDIR}"/${P}-gentoo.patch )

src_configure() {
	egamesconf $(use_enable nls)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog README
	prepgamesdirs
}
