# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/hatari/hatari-1.1.0.ebuild,v 1.1 2009/01/13 01:28:54 mr_bones_ Exp $

inherit games

DESCRIPTION="Atari ST emulator"
HOMEPAGE="http://hatari.berlios.de/"
SRC_URI="mirror://berlios/hatari/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="media-libs/libsdl
	sys-libs/readline
	media-libs/libpng
	sys-libs/zlib"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"
RDEPEND="${RDEPEND}
	games-emulation/emutos"

src_compile() {
	egamesconf || die
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
	elog "You need a TOS ROM to run hatari. EmuTOS, a free TOS implementation,"
	elog "has been installed in $(games_get_libdir) with a .img extension (there"
	elog "are several from which to choose)."
	elog
	elog "Another option is to go to http://www.atari.st/ and get a real TOS:"
	elog "  http://www.atari.st/"
	elog
	elog "The first time you run hatari, you should configure it to find the"
	elog "TOS you prefer to use.  Be sure to save your settings."
	echo
}
