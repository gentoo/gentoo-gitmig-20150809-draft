# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/fbg/fbg-0.9-r1.ebuild,v 1.8 2006/12/06 17:03:10 wolf31o2 Exp $

inherit games

DESCRIPTION="A tetris-clone written in OpenGL"
HOMEPAGE="http://home.attbi.com/~furiousjay/code/fbg.html"
SRC_URI="mirror://sourceforge/fbg/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc amd64"
IUSE=""

RDEPEND="virtual/opengl
	virtual/glu
	>=dev-games/physfs-0.1.7
	>=media-libs/libsdl-1.2.0
	>=media-libs/libmikmod-3.1.10"
DEPEND="${RDEPEND}
	x11-libs/libXt"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e "/FBGDATADIR=/s:\".*\":\"${GAMES_DATADIR}/${PN}\":" configure \
			|| die "sed configure failed"
}

src_compile() {
	egamesconf --disable-fbglaunch || die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
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
