# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gail/gail-0.13.ebuild,v 1.2 2002/07/11 06:30:25 drobbins Exp $

# Do _NOT_ strip symbols in the build! Need both lines for Portage 1.8.9+
DEBUG="yes"
RESTRICT="nostrip"
# force debug information
CFLAGS="${CFLAGS} -g"
CXXFLAGS="${CXXFLAGS} -g"

S=${WORKDIR}/${P}
DESCRIPTION="Part of Gnome Accessibility"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/pre-gnome2/sources/gail/${P}.tar.bz2"
HOMEPAGE="http://www.gnome.org/"

DEPEND=">=dev-util/pkgconfig-0.12.0
	>=x11-libs/gtk+-2.0.0
	>=dev-libs/glib-2.0.0
	>=x11-libs/pango-1.0.0
	>=dev-libs/atk-1.0.0
	>=gnome-base/libgnomecanvas-1.112.1"
		

src_compile() {
	local myconf
	./configure --host=${CHOST} \
		--prefix=/usr \
		--sysconfdir=/etc \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		--localstatedir=/var/lib \
		--enable-debug=yes || die "configure failure"
	emake || die "Make failure"
}

src_install() {
	make prefix=${D}/usr \
		sysconfdir=${D}/etc \
		infodir=${D}/usr/share/info \
		mandir=${D}/usr/share/man \
		localstatedir=${D}/var/lib \
		install || die "installation failure"
    
	dodoc AUTHORS ChangeLog COPYING README* INSTALL NEWS
}

