# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/beast/beast-0.4.1.ebuild,v 1.5 2003/03/03 12:59:38 vladimir Exp $

DESCRIPTION="BEAST - the Bedevilled Sound Engine"
HOMEPAGE="http://beast.gtk.org"
LICENSE="GPL"

DEPEND="dev-libs/glib
	dev-util/pkgconfig
	dev-util/guile
	media-libs/libart_lgpl
	>=x11-libs/gtk+-2.0.0
	gnome-base/gnome-libs
	gnome-base/libgnomecanvas
	media-sound/alsa-driver"

SRC_URI="ftp://beast.gtk.org/pub/beast/v0.4/${P}.tar.gz"
KEYWORDS="~x86"
SLOT="0"
S=${WORKDIR}/${P}

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING COPYING.LIB INSTALL README docs/*[faq.txt] 
}
