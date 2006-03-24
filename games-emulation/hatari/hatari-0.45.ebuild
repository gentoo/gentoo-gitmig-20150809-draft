# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/hatari/hatari-0.45.ebuild,v 1.7 2006/03/24 21:36:14 wolf31o2 Exp $

inherit games

DESCRIPTION="Atari ST emulator"
HOMEPAGE="http://hatari.sourceforge.net/"
SRC_URI="mirror://sourceforge/hatari/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE=""

RDEPEND="games-emulation/emutos
	media-libs/libsdl
	sys-libs/zlib"

src_unpack() {
	unpack ${A}
	cd ${S}

	sed -i \
		-e "/^CFLAGS/ s:-O3.*:${CFLAGS}:" \
		-e "/^DATADIR/ s:=.*:= ${GAMES_DATADIR}/${PN}:" Makefile.cnf \
		|| die "sed Makefile.cnf failed"
}

src_compile() {
	cd src
	emake || die "emake failed"
}

src_install() {
	dogamesbin "${S}/src/hatari" || die "dogamesbin failed"
	insinto "${GAMES_DATADIR}/${PN}"
	doins src/font8.bmp || die "doins font8.bmp failed"
	dodoc readme.txt doc/*.txt
	dohtml -r doc/
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
