# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/snes9x/snes9x-139-r1.ebuild,v 1.3 2002/07/15 01:32:03 rphillips Exp $

DESCRIPTION="Super Nintendo Entertainment System (SNES) emulator"
HOMEPAGE="http://www.snes9x.com/"
LICENSE="as-is"
SRC_URI="http://www.snes9x.com/zips/s9xs${PV}.zip"
DEPEND="dev-lang/nasm
		virtual/x11
		opengl? ( virtual/opengl )
		glide? ( media-libs/glide-v3 )"

S=${WORKDIR}/release

src_compile() {
	patch -p1 < ${FILESDIR}/snes9x-gcc3.diff
	emake -f Makefile.linux || die
	use opengl && ( emake -f Makefile.linux OPENGL=1 clean all || die )
	use glide  && ( emake -f Makefile.linux GLIDE=1 clean all || die )
}

src_install() {
	dobin snes9x ssnes9x
	use opengl && dobin osnes9x
	use glide && dobin gsnes9x
	dodoc COPYRIGHT.TXT CHANGES.TXT README.TXT PROBLEMS.TXT TODO.TXT HARDWARE.TXT
}

