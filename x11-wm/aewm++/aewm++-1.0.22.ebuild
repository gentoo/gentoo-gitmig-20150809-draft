# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/aewm++/aewm++-1.0.22.ebuild,v 1.1 2002/11/20 17:22:11 mkennedy Exp $

IUSE=""

DESCRIPTION="A window manager with more modern features than aewm but with the same look and feel."
HOMEPAGE="http://sapphire.sourceforge.net/"
SRC_URI="mirror://sourceforge/sapphire/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
DEPEND="virtual/x11"

S="${WORKDIR}/${P}"

src_compile() {
    make CFLAGS="${CXXFLAGS}" || die
}

src_install() {
	make DESTDIR=${D} XROOT=usr/ install || die
	dodoc ChangeLog INSTALL README LICENSE

	einfo "Edit your ~/.xinitrc and add: exec aewm++"
	einfo ""
	einfo "The goodies are now in x11-wm/aem"
}
