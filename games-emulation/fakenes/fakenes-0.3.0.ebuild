# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/fakenes/fakenes-0.3.0.ebuild,v 1.4 2004/03/07 20:26:55 mr_bones_ Exp $

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
	>=sys-apps/sed-4
	x86? ( dev-lang/nasm )"

src_unpack() {
	unpack ${A}
	cd ${S}
	chmod a+x configure
	epatch ${FILESDIR}/${PV}-allegro.patch
	if ! use fbcon ; then
		sed -i \
			-e '/sedfbme/s:.*::' src/gui.c src/include/gui/menus.h \
				|| die "sed fb failed"
	fi
	if ! use svga ; then
		sed -i \
			-e '/sedsvgalibme/s:.*::' src/gui.c src/include/gui/menus.h \
				|| die "sed svga failed"
	fi
}

src_compile() {
	egamesconf `use_with zlib` || die
	emake || die "emake failed"
}

src_install() {
	dogamesbin src/fakenes || die "dogamesbin failed"
	insinto "${GAMES_DATADIR}/${PN}"
	doins src/support/fakenes.{dat,ico,rc} || die "doins failed"
	dodoc CHANGES README SOURCE SUPPORT
	prepgamesdirs
}
