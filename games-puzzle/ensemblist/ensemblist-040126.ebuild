# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/ensemblist/ensemblist-040126.ebuild,v 1.6 2006/12/06 16:59:33 wolf31o2 Exp $

inherit games

DESCRIPTION="Put together several primitives to build a given shape. (C.S.G. Game)"
HOMEPAGE="http://www.nongnu.org/ensemblist/index_en.html"
SRC_URI="http://savannah.nongnu.org/download/ensemblist/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc x86"
IUSE=""

DEPEND="x11-libs/libXmu
	virtual/opengl
	virtual/glut
	virtual/glu
	media-libs/libpng
	media-libs/libmikmod"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e '/^CC/d' \
		-e '/strip/d' \
		-e "s:^DATADIR=.*:DATADIR=${GAMES_DATADIR}/${PN}/datas:" \
		-e "/^COMPILE_FLAGS/s/-Wall -O3 -fomit-frame-pointer/${CFLAGS}/" \
		Makefile || die "sed failed"
}

src_install() {
	dogamesbin ensemblist || die "dogamesbin failed"
	insinto "${GAMES_DATADIR}/${PN}"
	doins -r datas || die "doins failed"
	dodoc README Changelog
	prepgamesdirs
}
