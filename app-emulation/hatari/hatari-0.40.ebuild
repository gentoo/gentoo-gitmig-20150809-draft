# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/hatari/hatari-0.40.ebuild,v 1.3 2003/09/03 01:42:41 dholm Exp $

inherit games

DESCRIPTION="Atari ST emulator"
SRC_URI="mirror://sourceforge/hatari/${P}.tar.gz"
HOMEPAGE="http://hatari.sourceforge.net/"

LICENSE="GPL-2"
KEYWORDS="x86 ~ppc"
SLOT="0"

DEPEND="media-libs/libsdl
	sys-libs/zlib"

src_compile() {
	cd src
	emake \
		CMPLRFLAGS="${CFLAGS}" \
		DATADIR=${GAMES_DATADIR}/${PN} \
		|| die "emake failed"
}

src_install() {
	dogamesbin ${S}/src/hatari || die
	dodoc *.txt doc/*.txt
	dohtml doc/.html
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	einfo "You need a tos rom to run hatari, you can find EmuTOS here:"
	einfo "  http://emutos.sourceforge.net/  - Which is a free TOS implementation"
	einfo "or, go here and get a real TOS:"
	einfo "  http://www.atari.st/"
}
