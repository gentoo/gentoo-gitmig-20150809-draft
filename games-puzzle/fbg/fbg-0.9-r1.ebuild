# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/fbg/fbg-0.9-r1.ebuild,v 1.2 2004/02/04 20:05:36 dholm Exp $

inherit games

DESCRIPTION="A tetris-clone written in OpenGL"
HOMEPAGE="http://home.attbi.com/~furiousjay/code/fbg.html"
SRC_URI="mirror://sourceforge/fbg/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"

DEPEND="virtual/x11
	virtual/opengl
	virtual/glu
	>=dev-games/physfs-0.1.7
	>=media-libs/libsdl-1.2.0
	>=media-libs/libmikmod-3.1.10"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i "/FBGDATADIR=/s:\".*\":\"${GAMES_DATADIR}/${PN}\":" configure
}

src_compile() {
	egamesconf --disable-fbglaunch || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc README TODO AUTHORS

	# now clean up the install
	cd ${D}/${GAMES_PREFIX}
	rm -rf doc
	mv games ../share/

	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	einfo "less /usr/share/doc/${PF}/README.gz for play-instructions"
}
