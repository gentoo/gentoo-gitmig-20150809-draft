# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/crimson/crimson-0.5.0.ebuild,v 1.1 2006/12/10 18:08:26 mr_bones_ Exp $

inherit eutils games

DESCRIPTION="Tactical war game in the tradition of Battle Isle"
HOMEPAGE="http://crimson.seul.org/"
SRC_URI="http://crimson.seul.org/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE="zlib"

RDEPEND=">=media-libs/libsdl-1.1.5
	>=media-libs/sdl-mixer-1.2.4
	media-libs/sdl-ttf
	zlib? ( sys-libs/zlib )"
DEPEND="${RDEPEND}
	dev-libs/libxslt"

src_compile() {
	egamesconf \
		--disable-dependency-tracking \
		$(use_with zlib) \
		--enable-cfed \
		--enable-bi2cf \
		--enable-comet \
		--enable-cf2bmp \
		|| die
	emake || die "emake failed"
}

src_install() {
	make \
		DESTDIR="${D}" \
		pixmapsdir="/usr/share/pixmaps" \
		install || die "make install failed"
	dodoc NEWS README* THANKS TODO
	rm -rf "${D}/${GAMES_DATADIR}/applications"
	make_desktop_entry crimson "Crimson Fields" crimson.png
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst

	echo
	ewarn "Crimson Fields ${PV} is not save-game compatible with previous versions."
	echo
	einfo "If you have older save files and you wish to continue those games,"
	einfo "you'll need to remerge the version with which you started"
	einfo "those save-games."
}
