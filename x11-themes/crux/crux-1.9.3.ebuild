# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/crux/crux-1.9.3.ebuild,v 1.1 2002/06/29 13:20:15 seemant Exp $

DESCRIPTION="Crux is a gtk+2 theme engine that will replace the Eazel theme" 
HOMEPAGE="http://www.eazel.com"
S=${WORKDIR}/${P}
LICENSE="GPL-2"
SLOT="2"

RDEPEND=">=x11-libs/gtk+-2.0.5
	>=gnome-base/libgnomeui-2.0.1
	>=gnome-base/libglade-2.0.0"
DEPEND="${RDEPEND}
	sys-devel/libtool"
	
SRC_URI="mirror://gnome/sources/${PN}/${P}.tar.bz2"
src_compile() {
	econf
	emake || die " compile failed" 
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc AUTHORS  COPYING  ChangeLog INSTALL NEWS README THANKS TODO
}
