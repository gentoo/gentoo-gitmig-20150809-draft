# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/crimson/crimson-0.3.7.ebuild,v 1.4 2004/02/20 07:38:17 mr_bones_ Exp $

inherit games

DESCRIPTION="tactical war game in the tradition of Battle Isle"
HOMEPAGE="http://crimson.seul.org/"
SRC_URI="http://crimson.seul.org/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE="zlib"

DEPEND=">=libsdl-1.1.5
	>=sdl-mixer-1.2.4
	dev-libs/libxslt
	zlib? ( sys-libs/zlib )"

src_compile() {
	egamesconf \
		`use_enable zlib` \
		--enable-cfed \
		--enable-bi2cf \
		--enable-comet \
		|| die
	emake || die "emake failed"
}

src_install() {
	make install DESTDIR=${D} || die "make install failed"
	dodoc NEWS README* THANKS TODO
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
