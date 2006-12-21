# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/enigma/enigma-1.00.ebuild,v 1.1 2006/12/21 08:47:58 mr_bones_ Exp $

inherit eutils games

DESCRIPTION="puzzle game similar to Oxyd"
HOMEPAGE="http://www.nongnu.org/enigma/"
SRC_URI="http://download.berlios.de/enigma-game/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="nls"

RDEPEND="media-libs/sdl-ttf
	>=media-libs/libsdl-1.2.0
	>=media-libs/sdl-mixer-1.2.4
	>=media-libs/sdl-image-1.2.0
	>=dev-lang/lua-4.0
	dev-libs/xerces-c
	nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# fix up the locale install location
	if use nls ; then
		sed -i \
			-e "/^datadir/s:=.*:= /usr/share:" \
			po/Makefile.in.in \
			src/Makefile.am \
			|| die "sed failed"
	fi

	# thanks, we'll handle the doc install ourselves.
	sed -i \
		-e 's/: install-docDATA/:/' \
		-e '/^SUBDIRS/s/doc//' Makefile.in \
		|| die "sed failed"
}

src_compile() {
	egamesconf \
		--disable-dependency-tracking \
		--enable-optimize \
		$(use_enable nls) \
		|| die
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	mv "${D}/${GAMES_PREFIX}/share/"* "${D}/usr/share/"
	rm -r "${D}/${GAMES_PREFIX}/share"
	dodoc ACKNOWLEDGEMENTS AUTHORS CHANGES README doc/HACKING
	dohtml -r doc/*
	doman doc/enigma.6
	prepgamesdirs
}
