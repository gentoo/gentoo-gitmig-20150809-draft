# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Spider  <spider@gentoo.org>
# Maintainer: Spider <spider@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/libgtkhtml/libgtkhtml-1.99.7.ebuild,v 1.1 2002/05/22 22:36:08 spider Exp $

# Do _NOT_ strip symbols in the build! Need both lines for Portage 1.8.9+
DEBUG="yes"
RESTRICT="nostrip"
# force debug information
CFLAGS="${CFLAGS} -g"
CXXFLAGS="${CXXFLAGS} -g"


S=${WORKDIR}/${P}
DESCRIPTION="a Gtk+ based HTML rendering library"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/pre-gnome2/sources/libgtkhtml/${P}.tar.bz2"
HOMEPAGE="http://www.gnome.org/"
SLOT="1"
LICENSE="LGPL-2.1 GPL-2"

RDEPEND=">=x11-libs/gtk+-2.0.1
	>=dev-libs/libxml2-2.4.17
	>=gnome-base/gnome-vfs-1.9.10
	>=gnome-base/gail-0.9"


DEPEND="${RDEPEND}
	 >=dev-util/pkgconfig-0.12.0"

src_compile() {
	./configure --host=${CHOST} \
		--prefix=/usr \
		--sysconfdir=/etc \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		--enable-debug=yes || die "configure failure"
	emake || die "compile failure"
}

src_install() {
	make prefix=${D}/usr \
		sysconfdir=${D}/etc \
		infodir=${D}/usr/share/info \
		mandir=${D}/usr/share/man \
		install || die "install failure"
    
 	dodoc AUTHORS COPYING*  ChangeLog INSTALL NEWS  README* TODO 
	dodoc docs/IDEAS
}

