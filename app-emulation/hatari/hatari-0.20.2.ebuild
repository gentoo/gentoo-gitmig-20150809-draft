# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: David Holm <david@realityrift.com>
# $Header: /var/cvsroot/gentoo-x86/app-emulation/hatari/hatari-0.20.2.ebuild,v 1.5 2003/06/29 20:06:54 aliz Exp $

DESCRIPTION="Atari ST emulator"
SRC_URI="mirror://sourceforge.net/hatari/${P}.tar.gz"
HOMEPAGE="http://hatari.sourceforge.net/"

LICENSE="GPL-2"
KEYWORDS="x86"
SLOT="0"

DEPEND="media-libs/libsdl"

src_compile() {
	cd src
	emake || die
}

src_install () {
	dobin ${S}/src/hatari || die
	dodoc authors.txt ChangeLog readme.txt
}

pkg_postinst() {
	einfo "You need a tos rom to run hatari, you can find EmuTOS here:"
	einfo "  http://emutos.sourceforge.net/  - Which is a free TOS implementation"
	einfo "or, go here and get a real TOS:"
	einfo "  http://www.atari.st/"
}
