# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gliv/gliv-1.6.ebuild,v 1.6 2003/09/06 23:56:38 msterret Exp $

S=${WORKDIR}/${P}
DESCRIPTION="An image viewer that uses OpenGL"
SRC_URI="http://gliv.tuxfamily.org/gliv-${PV}.tar.bz2"
HOMEPAGE="http://gliv.tuxfamily.org"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

# Version 1.5.2 and later of gliv can use gtkglarea-1.99.0 or
# later, but will fail to compile if gtk+-2.0 is present, but
# not >=gtkglarea-1.99.0
#
# The basic theory here is that we just specify:
#
#   DEPEND="x11-libs/gtk+ x11-libs/gtkglarea"
#
# which will pull in whatever versions of both that is
# not masked.  We then check in src_compile() what version
# of gtkglarea should be used.
#
# Azarah - 20 Jun 2002

DEPEND="x11-libs/gtk+
	media-libs/gdk-pixbuf
	x11-libs/gtkglarea
	virtual/opengl
	>=dev-util/pkgconfig-0.12.0"

src_compile() {
	local myconf=""

	# Dont use gtk+-2.0 if ! gtkglarea >= 1.99.0
	if ! (pkg-config gtk+-2.0) || ! (pkg-config gtkgl-2.0)
	then
		einfo "Using Gtk+-1.2 and GtkGL-1.2"
		myconf="${myconf} --disable-gtk2"
	else
		einfo "Using Gtk+-2.0 and GtkGL-2.0"
	fi

	econf ${myconf} || die

	emake || die
}

src_install() {
	einstall || die

	dodoc COPYING README NEWS THANKS
}
