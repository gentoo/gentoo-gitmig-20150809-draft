# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Spider  <spider@gentoo.org>
# Maintainer: Spider <spider@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-base/eel/eel-1.1.14.ebuild,v 1.1 2002/05/22 20:53:28 spider Exp $

# Do _NOT_ strip symbols in the build! Need both lines for Portage 1.8.9+
DEBUG="yes"
RESTRICT="nostrip"
# force debug information
CFLAGS="${CFLAGS} -g"
CXXFLAGS="${CXXFLAGS} -g"

S=${WORKDIR}/${P}
DESCRIPTION="EEL is the Eazel Extentions Library"
SRC_URI="ftp://ftp.gnome.org/pub/gnome/pre-gnome2/sources/eel/${P}.tar.bz2"
HOMEPAGE="http://www.gnome.org/"
SLOT="2"
LICENSE="GPL-2 LGPL-2.1" 

RDEPEND=">=dev-libs/glib-2.0.0
	>=gnome-base/gconf-1.1.8
	>=x11-libs/gtk+-2.0.0
	>=media-libs/libart_lgpl-2.3.8
	>=dev-libs/libxml2-2.4.17
	>=gnome-base/gnome-vfs-1.9.10
	>=dev-libs/popt-1.6.3
	>=gnome-base/libbonobo-1.113.0
	>=gnome-base/libbonoboui-1.113.0
	>=gnome-base/bonobo-activation-0.9.6
	>=gnome-base/libgnome-1.112.0
	>=gnome-base/libgnomecanvas-1.112.1
	>=gnome-base/libgnomeui-1.112.1"

DEPEND="${RDEPEND} >=dev-util/pkgconfig-0.12.0"		

src_compile() {
	local myconf

	./configure --host=${CHOST} \
		    --prefix=/usr \
			--sysconfdir=/etc \
		    --infodir=/usr/share/info \
		    --mandir=/usr/share/man \
			--localstatedir=/var/lib \
			--enable-platform-gnome-2 \
		    --enable-debug=yes || die

	emake || die
}

src_install() {
	make prefix=${D}/usr \
		sysconfdir=${D}/etc \
		infodir=${D}/usr/share/info \
		mandir=${D}/usr/share/man \
		localstatedir=${D}/var/lib \
		install || die
    
	dodoc AUTHORS ChangeLog COPYING* HACKING THANKS README* INSTALL NEWS TODO MAINTAINERS
}

