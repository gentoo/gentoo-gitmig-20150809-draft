# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/enigma/enigma-0.92.ebuild,v 1.3 2006/10/05 18:11:51 nyhm Exp $

inherit eutils games

DESCRIPTION="puzzle game similar to Oxyd"
HOMEPAGE="http://www.nongnu.org/enigma/"
SRC_URI="http://savannah.nongnu.org/download/enigma/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc ~sparc x86"
IUSE="nls"

RDEPEND="media-libs/sdl-ttf
	>=media-libs/libsdl-1.2.0
	>=media-libs/sdl-mixer-1.2.4
	>=media-libs/sdl-image-1.2.0
	>=dev-lang/lua-4.0
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

	epatch "${FILESDIR}"/${P}-gcc41.patch
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
	make DESTDIR="${D}" install || die "make install failed"
	mv "${D}/${GAMES_PREFIX}/share/"* "${D}/usr/share/"
	rm -r "${D}/${GAMES_PREFIX}/share"
	dodoc NEWS README AUTHORS ChangeLog \
		doc/{TODO,CREATING-LEVELS,HACKING}
	dohtml -r doc/*
	doman doc/enigma.6
	prepgamesdirs
}
