# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Spider  <spider@gentoo.org>
# Maintainer: Spider <spider@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/bug-buddy/bug-buddy-2.1.6.ebuild,v 1.1 2002/05/22 22:17:20 spider Exp $

# Do _NOT_ strip symbols in the build! Need both lines for Portage 1.8.9+
DEBUG="yes"
RESTRICT="nostrip"
# force debug information
CFLAGS="${CFLAGS} -g"
CXXFLAGS="${CXXFLAGS} -g"

S=${WORKDIR}/${P}
DESCRIPTION="Bug Buddy is a Bug Report helper for Gnome"
SRC_URI="ftp://ftp.gnome.org/pub/gnome/pre-gnome2/sources/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.gnome.org/"
SLOT="2"
LICENSE="Ximian-logos GPL-2"

RDEPEND=">=gnome-base/gconf-1.1.8
	>=gnome-base/libglade-1.99.8
	>=dev-libs/libxml2-2.4.16
	>=gnome-base/gnome-vfs-1.9.10
	>=x11-libs/pango-1.0.0
	>=x11-libs/gtk+-2.0.0
	>=dev-libs/glib-2.0.0
	>=gnome-base/libbonobo-1.113.0
	>=gnome-base/libgnome-1.112.1
	>=gnome-base/libgnomecanvas-1.112.1
	>=gnome-base/libgnomeui-1.112.1
	>=gnome-base/ORBit2-2.3.106
	>=sys-devel/perl-5.0
	>=sys-devel/gdb-5.1
	>=sys-devel/gettext-0.10.40
	>=dev-lang/python-2.2"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0
        >=dev-util/intltool-0.17"

src_compile() {
	local myconf
	./configure --host=${CHOST} \
		    --prefix=/usr \
			--sysconfdir=/etc \
		    --infodir=/usr/share/info \
		    --mandir=/usr/share/man \
		    --localstatedir=/var/lib \
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
    
	dodoc ABOUT* AUTHORS ChangeLog COPY* README* INSTALL NEWS TODO 
}





