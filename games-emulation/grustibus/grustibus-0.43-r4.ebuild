# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/grustibus/grustibus-0.43-r4.ebuild,v 1.3 2004/01/24 13:56:16 mr_bones_ Exp $

DESCRIPTION="A GNOME-based front-end for the M.A.M.E. video game emulator"
HOMEPAGE="http://grustibus.sourceforge.net"
SRC_URI="mirror://sourceforge/grustibus/${P}.tar.gz"

KEYWORDS="x86"
LICENSE="GPL-2"
SLOT="0"
IUSE="nls"

DEPEND=">=games-emulation/xmame-0.56.1
	>=media-libs/gdk-pixbuf-0.17.0
	>=gnome-base/gnome-libs-1.4.1.2"

src_compile() {
	export CPPFLAGS=`gdk-pixbuf-config --cflags`
	econf `use_enable nls` || die
	emake || die "emake failed"
}

src_install() {
	einstall || die
	dodoc README INSTALL ChangeLog TODO NEWS || die "dodoc failed"
}
