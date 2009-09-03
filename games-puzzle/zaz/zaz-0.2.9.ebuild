# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/zaz/zaz-0.2.9.ebuild,v 1.1 2009/09/03 23:25:04 mr_bones_ Exp $

EAPI=2
inherit autotools eutils games

DESCRIPTION="A puzzle game where the player has to arrange balls in triplets"
HOMEPAGE="http://sourceforge.net/projects/zaz/"
SRC_URI="mirror://sourceforge/zaz/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="nls"

RDEPEND="virtual/opengl
	virtual/glu
	media-libs/libsdl[X,audio,video]
	media-libs/sdl-image[png]
	media-libs/libvorbis
	media-libs/libtheora
	media-libs/ftgl
	virtual/libintl"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

src_prepare() {
	epatch "${FILESDIR}"/${P}-build.patch
	eautoreconf
}

src_configure() {
	egamesconf \
		--disable-dependency-tracking \
		--localedir=/usr/share/locale \
		$(use_enable nls)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake failed"
	dodoc AUTHORS ChangeLog
	prepgamesdirs
}
