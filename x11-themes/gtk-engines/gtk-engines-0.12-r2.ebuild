# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gtk-engines/gtk-engines-0.12-r2.ebuild,v 1.4 2002/10/04 06:47:05 vapier Exp $

S=${WORKDIR}/${P}
DESCRIPTION="gtk-engines"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/${PN}/${P}.tar.gz
	http://download.themes.org/gtk/Xenophilia-1.2.x.tar.gz"
HOMEPAGE="http://www.gnome.org/"

DEPEND="virtual/glibc virtual/x11
	>=media-libs/imlib-1.9.10-r1"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

src_unpack() {
	unpack ${P}.tar.gz
	
	cd ${S}
	unpack Xenophilia-1.2.x.tar.gz
}

src_compile() {
	libtoolize --copy --force

	./configure --host=${CHOST} \
		--prefix=/usr || die
	
	make || die

	cd ${S}/Xenophilia-0.7
	make PREFIX=/usr \
		FONTDIR=/usr/X11R6/lib/X11/fonts/misc || die
}

src_install() {
	make prefix=${D}/usr install || die
	
	dodoc AUTHORS COPYING* ChangeLog README NEWS
	
	cd Xenophilia-0.7
	make PREFIX=${D}/usr \
		FONTDIR=/usr/X11R6/lib/X11/fonts/misc \
		install || die
		
	dodoc AUTHORS  CONFIGURATION TODO COPYING* ChangeLog README 
}

