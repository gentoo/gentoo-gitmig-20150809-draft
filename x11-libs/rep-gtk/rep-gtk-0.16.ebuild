# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/x11-libs/rep-gtk/rep-gtk-0.16.ebuild,v 1.3 2002/08/14 13:05:59 murphy Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Shared library implementing a Lisp dialect"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/pre-gnome2/sources/${PN}/${P}.tar.bz2"
HOMEPAGE="http://librep.sourceforge.net/"
SLOT="gtk-2.0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc sparc64"

# I think we should use gnome? ( ... ) and add "use gnome" with $myopts as rep-gtk
# can be compiled without gnome support, no ?
# I'm just adding deps to fix bug #3528 this time btw.
# stroke@gentoo.org

DEPEND="virtual/glibc
	>=dev-util/pkgconfig-0.12.0
	>=x11-libs/gtk+-2.0.3
	( >=dev-libs/librep-${PV}
	  <dev-libs/librep-20020000 )
	>=gnome-base/libbonobo-2.0.0
	>=gnome-base/libbonoboui-2.0.0
	>=gnome-base/libgnome-2.0.0
	>=gnome-base/libgnomeui-2.0.0
	>=gnome-base/libgnomecanvas-2.0.0
	>=gnome-base/libglade-2.0.0
	>=sys-devel/automake-1.6.1-r5"


src_compile() {

	./configure --host=${CHOST} \
	    --prefix=/usr \
	    --libexecdir=/usr/lib \
		--with-gnome \
		--with-libglade \
		--with-gdk-pixbuf \
	    --infodir=/usr/share/info || die

	emake host_type=${CHOST} || die
}

src_install() {

	make install \
		host_type=${CHOST} \
		installdir=${D}/usr/lib/rep/${CHOST} || die

	cd ${S}
	dodoc AUTHORS BUGS COPYING ChangeLog HACKING \
		NEWS README* TODO
}

