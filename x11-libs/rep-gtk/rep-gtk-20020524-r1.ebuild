# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/x11-libs/rep-gtk/rep-gtk-20020524-r1.ebuild,v 1.1 2002/06/09 13:59:54 stroke Exp $

# Do _NOT_ strip symbols in the build! Need both lines for Portage 1.8.9+
DEBUG="yes"
RESTRICT="nostrip"
# force debug information
CFLAGS="${CFLAGS} -g"
CXXFLAGS="${CXXFLAGS} -g"

MY_P=${PN}-2002-05-24
S=${WORKDIR}/${MY_P}
DESCRIPTION="Shared library implementing a Lisp dialect"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/pre-gnome2/sources/${PN}/${MY_P}.tar.bz2"
HOMEPAGE="http://librep.sourceforge.net/"

# I think we should use gnome? ( ... ) and add "use gnome" with $myopts as rep-gtk
# can be compiled without gnome support, no ?
# I'm just adding deps to fix bug #3528 this time btw.
# stroke@gentoo.org

DEPEND="virtual/glibc
	>=dev-util/pkgconfig-0.12.0
	>=x11-libs/gtk+-2.0.3
	>=dev-libs/librep-${PV}
	>=gnome-base/libbonobo-2.0.0
	>=gnome-base/libbonoboui-2.0.0
	>=gnome-base/libgnome-2.0.0
	>=gnome-base/libgnomeui-2.0.0
	>=gnome-base/libgnomecanvas-2.0.0
	>=gnome-base/libglade-2.0.0"

src_compile() {
	local myconf

	./configure --host=${CHOST} \
			--with-libglade \
		    --prefix=/usr \
		    --libexecdir=/usr/lib \
			--with-gnome --with-libglade \
		    --infodir=/usr/share/info || die

	emake || die
}

src_install() {
	make DESTDIR=${D} install || die

#	insinto /usr/include
#	doins src/rep_config.h
#	dodoc AUTHORS BUGS COPYING ChangeLog NEWS README THANKS TODO DOC
#	docinto doc
#	dodoc doc/*
}
