# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-sports/torcs/torcs-1.2.3.ebuild,v 1.1 2005/07/17 07:17:04 vapier Exp $

inherit games

DESCRIPTION="The Open Racing Car Simulator"
HOMEPAGE="http://torcs.org/"
SRC_URI="mirror://sourceforge/torcs/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=media-libs/plib-1.8.3
	virtual/opengl
	virtual/glut
	media-libs/libpng
	sys-libs/zlib"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e "/^datadir =/s:=.*:= ${GAMES_DATADIR}/${PN}:" \
		Make-config.in \
		|| die "sed Make-config.in failed"
}

src_compile() {
	egamesconf --x-libraries=/usr/lib || die
	emake -j1 || die
}

src_install() {
	make DESTDIR="${D}" install datainstall || die "make install failed"
	dosed "s:DATADIR=.*:DATADIR=${GAMES_DATADIR}/${PN}:" ${GAMES_BINDIR}/torcs
	dodoc README.linux
	dohtml *.html *.png
	prepgamesdirs
}
