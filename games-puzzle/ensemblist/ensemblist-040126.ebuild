# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/ensemblist/ensemblist-040126.ebuild,v 1.2 2004/10/17 09:25:29 dholm Exp $

inherit games

DESCRIPTION="Put together several primitives to build a given shape. (C.S.G. Game)"
HOMEPAGE="http://www.nongnu.org/ensemblist/index_en.html"
SRC_URI="http://savannah.nongnu.org/download/ensemblist/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE=""

DEPEND="virtual/x11
	virtual/opengl
	virtual/glut
	virtual/glu
	media-libs/libpng
	net-misc/curl
	media-libs/libmikmod"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e '/^CC/d' \
		-e "s:^DATADIR=.*:DATADIR=${GAMES_DATADIR}/${PN}/datas:" \
		-e "/^COMPILE_FLAGS/s/-Wall -O3 -fomit-frame-pointer/${CFLAGS}/" \
		Makefile || die "sed failed"
}

src_install() {
	dogamesbin ensemblist || die "dogamesbin failed"
	dodir "${GAMES_DATADIR}/${PN}"
	cp -r datas/ "${D}${GAMES_DATADIR}/${PN}" || die "cp failed"
	dodoc README Changelog
	prepgamesdirs
}
