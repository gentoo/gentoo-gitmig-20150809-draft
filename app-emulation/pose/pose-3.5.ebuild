# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/pose/pose-3.5.ebuild,v 1.9 2003/02/10 16:08:52 seemant Exp $

IUSE=""

S=${WORKDIR}/${P}
DESCRIPTION="Palm OS Emulator"
HOMEPAGE="http://www.palmos.com/dev/tools/emulator/"
SRC_URI="http://www.palmos.com/dev/tools/emulator/sources/emulator_src_3.5.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="=x11-libs/fltk-1.1.0*"

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

