# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/grustibus/grustibus-0.43-r4.ebuild,v 1.2 2003/09/09 23:33:23 msterret Exp $

S=${WORKDIR}/${P}
SRC_URI="mirror://sourceforge/grustibus/${P}.tar.gz"
HOMEPAGE="http://grustibus.sourceforge.net"
DESCRIPTION="A GNOME-based front-end for the M.A.M.E. video game emulator"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND=">=games-emulation/xmame-0.56.1
	>=media-libs/gdk-pixbuf-0.17.0
	>=gnome-base/gnome-libs-1.4.1.2"

src_compile() {
	local myconf
	export CPPFLAGS=`gdk-pixbuf-config --cflags`
	use nls || myconf="--disable-nls"
	econf ${myconf}
	emake || die
}

src_install() {
	einstall
	dodoc README INSTALL ChangeLog ABOUT-NLS TODO NEWS
}
