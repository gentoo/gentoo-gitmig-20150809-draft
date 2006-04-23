# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/epiar/epiar-0.5.ebuild,v 1.10 2006/04/23 20:36:44 tupone Exp $

inherit flag-o-matic eutils games

DESCRIPTION="A space adventure/combat game"
HOMEPAGE="http://epiar.net/"
SRC_URI="mirror://sourceforge/epiar/${P}.0-src.zip"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""

RDEPEND="media-libs/libsdl
	media-libs/sdl-image"
DEPEND="${RDEPEND}
	|| ( x11-libs/libX11 virtual/x11 )
	virtual/opengl
	app-arch/unzip"

S=${WORKDIR}

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e "/^CFLAGS/s:-pg -g:${CFLAGS}:" \
		Makefile.linux \
		|| die "sed failed"
	epatch "${FILESDIR}"/${PV}-gentoo-paths.patch \
		"${FILESDIR}/${P}"-gcc41.patch
	sed -i \
		-e "s:GENTOO_DATAPATH:${GAMES_DATADIR}/${PN}/:" \
		src/system/path.c \
		|| die "sed failed"
}

src_compile() {
	emake -f Makefile.linux || die "emake failed"
}

src_install() {
	dogamesbin epiar || die "dogamesbin failed"
	insinto "${GAMES_DATADIR}/${PN}"
	doins *.eaf || die "doins failed"
	insinto "${GAMES_DATADIR}/${PN}/missions"
	doins missions/*.eaf || die "doins failed"
	keepdir "${GAMES_DATADIR}/${PN}/plugins"
	dodoc AUTHORS ChangeLog README
	prepgamesdirs
}
