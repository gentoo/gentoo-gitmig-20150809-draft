# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Spider  <spider@gentoo.org>
# Maintainer: Spider <spider@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-base/libgnomecanvas/libgnomecanvas-1.117.0.ebuild,v 1.1 2002/05/22 22:04:00 spider Exp $

# Do _NOT_ strip symbols in the build! Need both lines for Portage 1.8.9+
DEBUG="yes"
RESTRICT="nostrip"
# force debug information
CFLAGS="${CFLAGS} -g"
CXXFLAGS="${CXXFLAGS} -g"


S=${WORKDIR}/${P}
DESCRIPTION="Canvas library"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/pre-gnome2/sources/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.gnome.org/"
SLOT="0"
LICENSE="GPL-2 LGPL-2.1" 


RDEPEND=">=gnome-base/libglade-1.99.11
	>=media-libs/libart_lgpl-2.3.8
	>=dev-libs/libxslt-1.0.16
	>=x11-libs/pango-1.0.0
	=media-libs/freetype-2.0*
	>=x11-libs/gtk+-2.0.2
	>=dev-libs/glib-2.0.0
	>=sys-devel/gettext-0.10.40
	>=sys-devel/perl-5.6.1
	>=sys-apps/gawk-3.1.0
	>=sys-devel/bison-1.28-r3"
												


DEPEND=">=dev-util/pkgconfig-0.12.0
	doc? ( >=dev-util/gtk-doc-0.9-r2 )
	${RDEPEND}"

src_compile() {
	local myconf
	libtoolize --copy --force
	use doc && myconf="${myconf} --enable-gtk-doc" || myconf="${myconf} --disable-gtk-doc"
	./configure --host=${CHOST} \
		    --prefix=/usr \
			--sysconfdir=/etc \
		    --infodir=/usr/share/info \
		    --mandir=/usr/share/man \
			${myconf} \
		    --enable-debug=yes || die

	emake || die
}

src_install() {
	make prefix=${D}/usr \
		sysconfdir=${D}/etc \
		infodir=${D}/usr/share/info \
		mandir=${D}/usr/share/man \
		install || die
    
	dodoc AUTHORS COPYING* ChangeLog INSTALL NEWS README
}





