# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/fakenes/fakenes-0.3.1.ebuild,v 1.3 2006/12/06 17:12:19 wolf31o2 Exp $

inherit eutils games

DESCRIPTION="portable, Open Source NES emulator which is written mostly in C"
HOMEPAGE="http://fakenes.sourceforge.net/"
SRC_URI="mirror://sourceforge/fakenes/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="zlib fbcon svga"

RDEPEND=">=media-libs/allegro-4.1
	zlib? ( sys-libs/zlib )
	dev-games/hawknl"
DEPEND="${RDEPEND}
	x86? ( dev-lang/nasm )"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# this is a hack simply because upstream seems kind
	# of dead atm ... if they ever revive, we can do this
	# properly by making an autoconf patch ...
	epatch "${FILESDIR}/${PV}-allegro.patch"
	if ! use fbcon ; then
		sed -i \
			-e '/sedfbme/s:.*::' \
			src/gui.c src/include/gui/menus.h \
			|| die "sed fb failed"
	fi
	if ! use svga ; then
		sed -i \
			-e '/sedsvgalibme/s:.*::' \
			src/gui.c src/include/gui/menus.h \
			|| die "sed svga failed"
	fi

	# fix bad AC_ARG_WITH() configure invocation
	sed -i \
		-e '/USE_/s:$enableval:$withval:' \
		configure || die

	# fix bad distribution
	chmod a+x configure
	edos2unix $(find -type f)
}

src_compile() {
	egamesconf \
		--with-hawknl \
		$(use_with zlib) \
		|| die
	emake || die "emake failed"
}

src_install() {
	dogamesbin src/fakenes || die "dogamesbin failed"
	insinto "${GAMES_DATADIR}/${PN}"
	doins src/support/fakenes.{dat,ico,rc} || die "doins failed"
	dodoc CHANGES README SOURCE SUPPORT
	prepgamesdirs
}
