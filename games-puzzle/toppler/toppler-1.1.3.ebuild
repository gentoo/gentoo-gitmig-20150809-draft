# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/toppler/toppler-1.1.3.ebuild,v 1.6 2010/11/02 09:29:35 tupone Exp $

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
PATCHES=( "${FILESDIR}"/${P}-gentoo.patch
	"${FILESDIR}"/${P}-ovflfix.patch )

src_configure() {
	egamesconf $(use_enable nls)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog README
	prepgamesdirs
}
