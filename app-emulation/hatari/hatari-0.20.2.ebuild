# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: David Holm <david@realityrift.com>
# $Header: /var/cvsroot/gentoo-x86/app-emulation/hatari/hatari-0.20.2.ebuild,v 1.1 2002/12/12 00:14:13 rphillips Exp $

S="${WORKDIR}/${P}"
DESCRIPTION="HAtari is an Atari ST emulator"
SRC_URI="http://belnet.dl.sourceforge.net/sourceforge/hatari/${P}.tar.gz"
HOMEPAGE="http://hatari.sourceforge.net/"
LICENSE="GPL-2"
DEPEND="media-libs/libsdl"
IUSE=""
KEYWORDS="~x86"

src_compile() {
	cd ${S}/src
	emake || die
}

src_install () {
	# Install binary
	dobin ${S}/src/hatari || die

	# Install documentation.
	dodoc authors.txt ChangeLog readme.txt
}

pkg_postinst() {
	einfo "You need a tos rom to run hatari, you can find EmuTOS here:"
	einfo "  http://emutos.sourceforge.net/  - Which is a free TOS implementation"
	einfo "or, go here and get a real TOS:"
	einfo "  http://www.atari.st/"
}
