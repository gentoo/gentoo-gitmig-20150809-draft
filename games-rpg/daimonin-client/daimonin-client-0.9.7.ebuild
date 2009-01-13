# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-rpg/daimonin-client/daimonin-client-0.9.7.ebuild,v 1.2 2009/01/13 02:34:45 mr_bones_ Exp $

EAPI=2
inherit eutils games

MY_P=${PN/-/_}-${PV}
DESCRIPTION="a graphical 2D tile-based MMORPG"
HOMEPAGE="http://daimonin.sourceforge.net/"
SRC_URI="mirror://sourceforge/daimonin/${MY_P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-amd64 ~ppc ~x86"
IUSE=""

DEPEND="media-libs/libsdl
	media-libs/sdl-mixer[vorbis]
	media-libs/sdl-image[png]"

S=${WORKDIR}/${MY_P}/make/linux

src_prepare() {
	sed -i \
		-e 's:$(d_datadir):$(DESTDIR)$(d_datadir):' \
		-e '/PROGRAMS/s:updater::' \
		-e '/\/tools/d' \
		Makefile.in \
		|| die "sed failed"
	chmod +x configure
}

src_configure() {
	egamesconf --disable-simplelayout
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	cd ../..
	dodoc README*
	newicon bitmaps/pentagram.png ${PN}.png
	make_desktop_entry daimonin Daimonin
	prepgamesdirs
}
