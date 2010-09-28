# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/lib765/lib765-0.4.2.ebuild,v 1.1 2010/09/28 20:48:58 jer Exp $

EAPI="2"

inherit autotools

DESCRIPTION="Floppy controller emulator"
HOMEPAGE="http://www.seasip.demon.co.uk/Unix/LibDsk/"
SRC_URI="http://www.seasip.demon.co.uk/Unix/LibDsk/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS="~amd64 ~ppc ~x86"

DEPEND="app-emulation/libdsk"

src_prepare() {
	eautoreconf
}

src_configure() {
	econf --with-libdsk || die
}

src_install() {
	make install DESTDIR=${D} || die
	dodoc ChangeLog doc/765.txt
}
