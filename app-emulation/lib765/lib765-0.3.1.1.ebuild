# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/lib765/lib765-0.3.1.1.ebuild,v 1.3 2004/02/20 06:08:34 mr_bones_ Exp $

DESCRIPTION="Floppy controller emulator"
HOMEPAGE="http://www.seasip.demon.co.uk/Unix/LibDsk/"
SRC_URI="http://www.seasip.demon.co.uk/Unix/LibDsk/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"

DEPEND="app-emulation/libdsk"

src_compile() {
	econf --with-libdsk || die
	emake || die "lib765 make failed!"
}

src_install() {
	make install DESTDIR=${D} || die
	dodoc ChangeLog doc/765.txt
}
