# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Spider  <spider@gentoo.org>
# Maintainer: Spider  <spider@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-base/libgnomeprintui/libgnomeprintui-1.114.0.ebuild,v 1.1 2002/06/02 18:07:41 stroke Exp $



# Do _NOT_ strip symbols in the build! Need both lines for Portage 1.8.9+
DEBUG="yes"
RESTRICT="nostrip"
# force debug information
CFLAGS="${CFLAGS} -g"
CXXFLAGS="${CXXFLAGS} -g"


S=${WORKDIR}/${P}
DESCRIPTION="user interface libraries for gnome print"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/pre-gnome2/sources/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.gnome.org/"
SLOT="0"
LICENSE="GPL-2 LGPL-2.1"

RDEPEND=">=gnome-base/libgnomeui-1.117.2
	>=gnome-extra/libgnomeprint-1.114.0
	>=gnome-base/libgnomecanvas-1.112.1"

DEPEND="${RDEPEND} >=dev-util/pkgconfig-0.12.0"

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
		install || die
    
 	dodoc AUTHORS COPYING* ChangeLog INSTALL NEWS README 
}

