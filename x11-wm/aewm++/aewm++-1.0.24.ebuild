# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/aewm++/aewm++-1.0.24.ebuild,v 1.3 2004/05/07 21:06:23 tseng Exp $

DESCRIPTION="A window manager with more modern features than aewm but with the same look and feel."
HOMEPAGE="http://sapphire.sourceforge.net/"
SRC_URI="mirror://sourceforge/sapphire/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64"
DEPEND="virtual/x11"
IUSE=""

src_compile() {
	make CFLAGS="${CXXFLAGS}" || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc ChangeLog README LICENSE
}
