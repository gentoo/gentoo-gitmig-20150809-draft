# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/enigma/enigma-1.01.ebuild,v 1.2 2008/04/30 15:40:10 nyhm Exp $

inherit autotools eutils games

DESCRIPTION="puzzle game similar to Oxyd"
HOMEPAGE="http://www.nongnu.org/enigma/"
SRC_URI="mirror://berlios/enigma-game/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="nls"

RDEPEND="media-libs/sdl-ttf
	media-libs/libsdl
	media-libs/sdl-mixer
	media-libs/sdl-image
	dev-libs/xerces-c
	net-libs/enet
	nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	sys-devel/gettext"

src_unpack() {
	unpack ${A}
	cd "${S}"
	cp /usr/share/gettext/config.rpath .
	epatch \
		"${FILESDIR}"/${P}-autotools.patch \
		"${FILESDIR}"/${P}-gcc43.patch
	eautoreconf
}

src_compile() {
	egamesconf \
		--disable-dependency-tracking \
		$(use_enable nls) \
		|| die
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc ACKNOWLEDGEMENTS AUTHORS CHANGES README doc/HACKING
	dohtml -r doc/*
	doman doc/enigma.6
	prepgamesdirs
}
