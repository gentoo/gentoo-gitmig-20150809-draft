# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/hatari/hatari-0.45.ebuild,v 1.2 2004/02/20 06:26:47 mr_bones_ Exp $

inherit games

DESCRIPTION="Atari ST emulator"
SRC_URI="mirror://sourceforge/hatari/${P}.tar.gz"
HOMEPAGE="http://hatari.sourceforge.net/"

LICENSE="GPL-2"
KEYWORDS="x86 ~ppc"
SLOT="0"

RDEPEND="games-emulation/emutos
	media-libs/libsdl
	sys-libs/zlib"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd ${S}

	sed -i \
		-e "/^CFLAGS/ s:-O3.*:${CFLAGS}:" \
		-e "/^DATADIR/ s:=.*:= ${GAMES_DATADIR}/${PN}:" Makefile.cnf || \
			die "sed Makefile.cnf failed"
}

src_compile() {
	cd src
	emake || die "emake failed"
}

src_install() {
	dogamesbin ${S}/src/hatari || die "dogamesbin failed"
	insinto ${GAMES_DATADIR}/${PN}
	doins src/font8.bmp        || die "doins failed"
	dodoc readme.txt doc/*.txt || die "dodoc failed"
	dohtml doc/                || die "dohtml failed"
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	echo
	einfo "You need a TOS ROM to run hatari. EmuTOS, a free TOS implementation,"
	einfo "has been installed in /usr/games/lib/ with a .img extension (there"
	einfo "are several from which to choose)."
	echo
	einfo "Another option is to go to http://www.atari.st/ and get a real TOS:"
	einfo "  http://www.atari.st/"
	echo
	einfo "The first time you run hatari, you should configure it to find the"
	einfo "TOS you prefer to use.  Be sure to save your settings."
	echo
}
