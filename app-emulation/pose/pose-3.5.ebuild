# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# /space/gentoo/cvsroot/gentoo-x86/dev-lang/gpc/gpc-20020410.ebuild,v 1.2 2002/04/27 23:08:36 bangert Exp

S=${WORKDIR}/${P}
HOMEPAGE="http://www.palmos.com/dev/tools/emulator/"
SRC_URI="http://www.palmos.com/dev/tools/emulator/sources/emulator_src_3.5.tar.gz"

DESCRIPTION="Palm OS Emulator"

DEPEND="=x11-libs/fltk-1.1.0_beta10-r1"
KEYWORDS="x86"
LICENSE="GPL-2"
SLOT="0"
src_compile() {
	cd ${WORKDIR}/Emulator_Src_3.5/BuildUnix
	./configure || die

	make ||die
}

src_install() {
	cd ${WORKDIR}/Emulator_Src_3.5/BuildUnix
	make prefix=${D}/usr/ install || die

	cd ${WORKDIR}/Emulator_Src_3.5/Docs
	dodoc *.txt
	insinto /usr/share/doc/${P}
	doins *.pdf *.rtf *.html
}

