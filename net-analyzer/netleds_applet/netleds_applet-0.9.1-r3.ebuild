# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/netleds_applet/netleds_applet-0.9.1-r3.ebuild,v 1.4 2002/08/14 12:12:28 murphy Exp $


S=${WORKDIR}/${P}
DESCRIPTION="Gnome applet that displays leds from network load"
SRC_URI="http://netleds.port5.com/${P}.tar.gz"
HOMEPAGE="http://netleds.port5.com/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc sparc64"

DEPEND=">=gnome-base/gnome-core-1.4.0.4-r1
	>=gnome-base/libgtop-1.0.12-r1"

src_compile() {
	
	econf || die
	emake || die
}

src_install() {
	
	einstall || die
	
	dodoc AUTHORS COPYING ChangeLog NEWS README TODO
}
