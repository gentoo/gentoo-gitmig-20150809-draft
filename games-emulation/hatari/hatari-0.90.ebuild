# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/hatari/hatari-0.90.ebuild,v 1.2 2007/02/06 06:14:44 mr_bones_ Exp $

inherit games

DESCRIPTION="Atari ST emulator"
HOMEPAGE="http://hatari.sourceforge.net/"
SRC_URI="mirror://sourceforge/hatari/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="media-libs/libsdl
	sys-libs/zlib"
RDEPEND="${DEPEND}
	games-emulation/emutos"

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i \
		-e '/^CC/d' \
		-e "/^CFLAGS/ s:=.*:=${CFLAGS}:" \
		-e "/^DATADIR/ s:=.*:= ${GAMES_DATADIR}/${PN}:" Makefile.cnf \
		|| die "sed Makefile.cnf failed"
}

src_compile() {
	# broken deps in the makefiles - bug #164068
	emake -C src/uae-cpu gencpu || die "emake failed"
	emake -C src/uae-cpu all || die "emake failed"
	emake -C src || die "emake failed"
}

src_install() {
	dogamesbin "${S}/src/hatari" || die "dogamesbin failed"
	insinto "${GAMES_DATADIR}/${PN}"
	doins src/gui-sdl/font5x8.bmp src/gui-sdl/font10x16.bmp \
		|| die "doins failed"
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
