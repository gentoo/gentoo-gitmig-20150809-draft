# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/netleds_applet/netleds_applet-0.9.1-r3.ebuild,v 1.1 2002/06/17 06:19:42 seemant Exp $


S=${WORKDIR}/${P}
DESCRIPTION="Gnome applet that displays leds from network load"
SRC_URI="http://netleds.port5.com/${P}.tar.gz"
HOMEPAGE="http://netleds.port5.com/"

SLOT=""
LICENSE="GPL-2"

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
