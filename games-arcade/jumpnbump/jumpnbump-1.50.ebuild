# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/jumpnbump/jumpnbump-1.50.ebuild,v 1.4 2004/08/31 09:12:36 mr_bones_ Exp $

inherit games

DESCRIPTION="a funny multiplayer game about cute little fluffy bunnies"
HOMEPAGE="http://www.jumpbump.mine.nu/"
SRC_URI="http://www.jumpbump.mine.nu/port/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc ~amd64"
IUSE="X svga fbcon"

RDEPEND="virtual/libc
	X? ( virtual/x11 )
	>=media-libs/sdl-mixer-1.2
	>=media-libs/libsdl-1.2
	>=media-libs/sdl-net-1.2"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i \
		-e 's:/share/jumpnbump/:/share/games/jumpnbump/:' \
		-e 's:cd sdl && make:$(MAKE) -C sdl:' \
		-e 's:cd modify && make:$(MAKE) -C modify:' \
		-e 's:cd data && make:$(MAKE) -C data:' \
		-e 's:\$(PREFIX)/games/$:$(PREFIX)/games/bin/:g' Makefile || \
			die 'sed Makefile failed'

	if ! use svga ; then
		sed -i \
			-e '/^BINARIES/s/jumpnbump.svgalib//' Makefile || \
				die 'sed Makefile failed'
	fi

	if ! use fbcon ; then
		sed -i \
			-e '/^BINARIES/s/jumpnbump.fbcon//' Makefile || \
				die 'sed Makefile failed'
	fi

	sed -i \
		-e 's:/share/jumpnbump/:/share/games/jumpnbump/:' globals.pre || \
			die 'sed globals.pre failed'

	sed -i \
		-e 's:%%PREFIX%%/games/:%%PREFIX%%/share/games/:' \
		-e 's:/share/jumpnbump/:/share/games/jumpnbump/:' jnbmenu.pre || \
			die 'sed jnbmenu.pre failed'
}

src_compile() {
	emake -j1 PREFIX=/usr || die "emake failed"
}

src_install() {
	make PREFIX="${D}/usr" install || die "make install failed"
	prepgamesdirs
}
