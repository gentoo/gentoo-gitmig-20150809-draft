# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/crux/crux-1.9.2.ebuild,v 1.3 2002/10/22 15:45:01 bjb Exp $

DESCRIPTION="Crux is a gtk+2 theme engine that will replace the Eazel theme" 
HOMEPAGE="http://www.eazel.com"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 alpha"

RDEPEND=">=x11-libs/gtk+-2.0.2
	>=gnome-base/libgnomeui-1.117.1
	>=gnome-base/libglade-1.99.12"
DEPEND="${RDEPEND}
	sys-devel/libtool"
	
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/pre-gnome2/sources/${PN}/${P}.tar.bz2"
src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"
	emake || die " compile failed" 
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc AUTHORS  COPYING  ChangeLog INSTALL NEWS README THANKS TODO
}
