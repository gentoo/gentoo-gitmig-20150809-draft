# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/x11-wm/sawfish/sawfish-2.0.ebuild,v 1.4 2002/09/17 16:54:14 kain Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Extensible window manager using a Lisp-based scripting language"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/pre-gnome2/sources/${PN}/${P}.tar.bz2"
HOMEPAGE="http://sawmill.sourceforge.net/"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc sparc64 ppc"

DEPEND=">=dev-util/pkgconfig-0.12.0
	( >=x11-libs/rep-gtk-0.16
	  <x11-libs/rep-gtk-20020000 )
	( >=dev-libs/librep-0.16
	  <dev-libs/librep-20020000 )
	>=media-libs/imlib-1.9.10-r1
	media-libs/audiofile
	esd? ( >=media-sound/esound-0.2.22 )
	readline? ( >=sys-libs/readline-4.1 )
	nls? ( sys-devel/gettext )"


src_unpack() {

	unpack ${A}

	# gdk-pixbuf support is now in gui.gtk-2.gtk
	#
	# Azarah - 23 Jun 2002
	cd ${S}
	patch -p1 <${FILESDIR}/${P}-rep-gtk.patch || die
}

src_compile() {

	local myconf=""
	use esd && myconf="${myconf} --with-esd"
	use esd || myconf="${myconf} --without-esd"
	
	use readline && myconf="${myconf} --with-readline"
	use readline || myconf="${myconf} --without-readline"
	
	use nls || myconf="${myconf} --disable-linguas"
	
	# The themer is currently broken (must have rep-gtk-0.15
	# installed to get it compiled) - Azarah, 24 Jun 2002
	./configure --host=${CHOST} \
		--prefix=/usr  \
		--infodir=/usr/share/info \
		--libexecdir=/usr/lib \
		--with-gnome-prefix=/usr \
		--enable-gnome-widgets \
		--enable-capplet \
		--disable-themer \
		--with-gdk-pixbuf \
		--with-audiofile \
		${myconf} || die

	# DO NOT USE "emake" !!! - Azarah, 24 Jun 2002
	make || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS BUGS COPYING ChangeLog DOC FAQ NEWS README THANKS TODO
	
	# Add to Gnome CC's Window Manager list
	insinto /usr/share/gnome/wm-properties
	doins ${FILESDIR}/Sawfish.desktop
}



