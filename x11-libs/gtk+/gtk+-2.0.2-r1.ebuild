# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Spider  <spider@gentoo.org>
# /space/gentoo/cvsroot/gentoo-x86/dev-libs/glib/glib-1.3.14.ebuild,v 1.1 2002/02/20 22:11:06 gbevin Exp

# ACONFVER=2.52f
# AMAKEVER=1.5b
# Source inherit.eclass and inherit AutoTools
# . /usr/portage/eclass/inherit.eclass  || die
# inherit autotools 

SLOT="2"

S=${WORKDIR}/${P}
DESCRIPTION="Gimp ToolKit + "
SRC_URI="ftp://ftp.gtk.org/pub/gtk/v2.0/${P}.tar.bz2"
HOMEPAGE="http://www.gtk.org/"

DEPEND="virtual/x11
		>=dev-util/pkgconfig-0.12.0
		>=dev-libs/glib-2.0.1
		>=dev-libs/atk-1.0.1
		>=x11-libs/pango-1.0.1
		>=media-libs/libpng-1.2.1
		>=media-libs/jpeg-6b-r2
		>=media-libs/tiff-3.5.7
		doc? ( >=dev-util/gtk-doc-0.9-r2 )"

src_compile() {
	local myconf
	use doc && myconf="${myconf} --enable-gtk-doc" || myconf="${myconf} --disable-gtk-doc"
	
	./configure --host=${CHOST} \
		--prefix=/usr \
		--sysconfdir=/etc \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		--with-gdktarget=x11 \
		${myconf} \
		--enable-debug || die
# enable debug since glib fails if we disable it
	emake || die
}

src_install() {
	make DESTDIR=${D} \
		prefix=/usr \
		sysconfdir=/etc \
		infodir=/usr/share/info \
		mandir=/usr/share/man \
		install || die
	dodoc AUTHORS COPYING ChangeLog* HACKING* INSTALL NEWS* README* TODO
}





