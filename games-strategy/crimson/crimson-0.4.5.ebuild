# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/crimson/crimson-0.4.5.ebuild,v 1.2 2004/11/24 21:28:25 josejx Exp $

inherit eutils games

DESCRIPTION="Tactical war game in the tradition of Battle Isle"
HOMEPAGE="http://crimson.seul.org/"
SRC_URI="http://crimson.seul.org/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64 ppc"
IUSE="zlib"

DEPEND=">=media-libs/libsdl-1.1.5
	>=media-libs/sdl-mixer-1.2.4
	media-libs/sdl-ttf
	dev-libs/libxslt
	zlib? ( sys-libs/zlib )"

src_compile() {
	egamesconf \
		--disable-dependency-tracking \
		$(use_enable zlib) \
		--enable-cfed \
		--enable-bi2cf \
		--enable-comet \
		|| die
	emake || die "emake failed"
}

src_install() {
	make \
		DESTDIR="${D}" \
		pixmapsdir="/usr/share/pixmaps" \
		install || die "make install failed"
	dodoc NEWS README* THANKS TODO
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
