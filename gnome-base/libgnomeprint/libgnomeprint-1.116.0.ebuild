# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/gnome-base/libgnomeprint/libgnomeprint-1.116.0.ebuild,v 1.4 2002/09/21 11:49:09 bjb Exp $


inherit libtool

S=${WORKDIR}/${P}
DESCRIPTION="Printer handling for Gnome"
SRC_URI="mirror://gnome/2.0.0/sources/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.gnome.org/"
SLOT="0"
KEYWORDS="x86 ppc sparc sparc64 alpha"
LICENSE="GPL-2 LGPL-2.1"


RDEPEND=">=gnome-base/libbonobo-2.0.0
	>=media-libs/libart_lgpl-2.3.8
	>=x11-libs/pango-1.0.0
	>=dev-libs/libxml2-2.4.22
	>=dev-libs/glib-2.0.0
	>=media-libs/freetype-2.0.9"
		
DEPEND="${RDEPEND} 
	>=dev-util/pkgconfig-0.12.0
	doc? ( dev-util/gtk-doc )"
	
src_compile() {
	elibtoolize
	local myconf
	 use doc && myconf="--enable-gtk-doc" || myconf="--disable-gtk-doc"
	 
	./configure --host=${CHOST} \
		--prefix=/usr \
		--sysconfdir=/etc \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		--disable-font-install \
		--enable-platform-gnome-2 \
		${myconf} || die "configure failure"

	emake || die "compile failure"
}

src_install() {
	make DESTDIR=${D} \
		prefix=/usr \
		sysconfdir=/etc \
		infodir=/usr/share/info \
		mandir=/usr/share/man \
		install || die
    
	dodoc AUTHORS COPYING*  ChangeLog* INSTALL NEWS README 
}

pkg_postinst() {
	echo ">>> Updating Fonts"
	libgnomeprint-2.0-font-install \
		--debug \
		--smart \
		--static \
		--aliases=/usr/share/gnome/libgnomeprint-2.0/fonts/adobe-urw.font \
		--target=/usr/share/gnome/libgnomeprint-2.0/fonts/gnome-print.fontmap
				
} 
