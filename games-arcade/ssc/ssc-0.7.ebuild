# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/ssc/ssc-0.7.ebuild,v 1.5 2004/07/14 14:27:50 agriffis Exp $

inherit games

DESCRIPTION="2D Geometric Space Combat"
SRC_URI="mirror://sourceforge/sscx/${P}.tar.bz2"
RESTRICT="nomirror"
HOMEPAGE="http://sscx.sourceforge.net/"

KEYWORDS="x86"
IUSE=""
LICENSE="GPL-2"
SLOT="0"

RDEPEND="virtual/opengl
	virtual/glu
	media-libs/sdl-mixer"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd ${S}

	sed -i \
		-e "/fileNames/ s:wav/:${GAMES_DATADIR}/${PN}/wav/:" src/audio.cc || \
			die "sed src/audio.cc failed"
}

src_install () {
	make DESTDIR=${D} install                || die "make install failed"
	dodir ${GAMES_DATADIR}/${PN}             || die "dodir failed"
	cp -r wav/ ${D}${GAMES_DATADIR}/${PN}    || die "cp failed"
	dodoc AUTHORS ChangeLog NEWS README TODO || die "dodoc failed"
}
