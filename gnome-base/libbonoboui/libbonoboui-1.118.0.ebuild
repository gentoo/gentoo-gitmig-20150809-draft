# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/gnome-base/libbonoboui/libbonoboui-1.118.0.ebuild,v 1.1 2002/06/02 00:25:37 spider Exp $

# Do _NOT_ strip symbols in the build! Need both lines for Portage 1.8.9+
DEBUG="yes"
RESTRICT="nostrip"
# force debug information
CFLAGS="${CFLAGS} -g"
CXXFLAGS="${CXXFLAGS} -g"


S=${WORKDIR}/${P}
DESCRIPTION="User Interface part of Lib bonobo"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/pre-gnome2/sources/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.gnome.org/"
SLOT="0"
LICENSE="GPL-2 LGPL-2.1"

RDEPEND=">=gnome-base/libglade-1.99.10
	>=media-libs/libart_lgpl-2.3.8-r1
	>=gnome-base/libgnome-1.117.2
	>=gnome-base/libgnomecanvas-1.117.0
	>=gnome-base/bonobo-activation-1.0.0
	>=gnome-base/libbonobo-2.0.0
	>=gnome-base/gconf-1.1.10
	>=x11-libs/gtk+-2.0.0
	>=dev-libs/glib-2.0.0"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0
        >=dev-util/intltool-0.17"


src_compile() {
	local myconf
#	libtoolize --copy --force
	./configure --host=${CHOST} \
		--prefix=/usr \
		--sysconfdir=/etc \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		--enable-debug=yes || die "configure failure"

	make || die "compile failure"
}

src_install() {
	make prefix=${D}/usr \
		sysconfdir=${D}/etc \
		infodir=${D}/usr/share/info \
		mandir=${D}/usr/share/man \
		install || die
    
	dodoc AUTHORS COPYING* ChangeLog INSTALL NEWS README 
}





