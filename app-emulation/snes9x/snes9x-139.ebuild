# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/snes9x/snes9x-139.ebuild,v 1.6 2002/11/02 23:39:56 gerk Exp $

DESCRIPTION="Snes9x is a portable, freeware Super Nintendo Entertainment System (SNES) emulator."
HOMEPAGE="http://www.snes9x.com/"
LICENSE="as-is"
KEYWORDS="x86 -ppc"
SLOT="0"
SRC_URI="http://www.snes9x.com/zips/s9xs${PV}.zip"
DEPEND="dev-lang/nasm
		virtual/x11"
S=${WORKDIR}/release

src_compile() {
	make -f Makefile.linux || die
}

src_install() {
	dobin ssnes9x
	dodoc COPYRIGHT.TXT CHANGES.TXT README.TXT PROBLEMS.TXT TODO.TXT HARDWARE.TXT
}
