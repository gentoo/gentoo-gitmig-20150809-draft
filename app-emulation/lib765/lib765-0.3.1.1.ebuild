# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/lib765/lib765-0.3.1.1.ebuild,v 1.8 2005/05/21 10:45:50 blubb Exp $

DESCRIPTION="Floppy controller emulator"
HOMEPAGE="http://www.seasip.demon.co.uk/Unix/LibDsk/"
SRC_URI="http://www.seasip.demon.co.uk/Unix/LibDsk/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS="x86 ppc ~amd64"

DEPEND="app-emulation/libdsk"

src_compile() {
	econf --with-libdsk || die
	emake || die "lib765 make failed!"
}

src_install() {
	make install DESTDIR=${D} || die
	dodoc ChangeLog doc/765.txt
}
