# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/x11-libs/gtk+/gtk+-2.0.5-r2.ebuild,v 1.1 2002/07/15 11:17:49 seemant Exp $

inherit libtool

SLOT="2"
KEYWORDS="x86"

# Do _NOT_ strip symbols in the build! Need both lines for Portage 1.8.9+
DEBUG="yes"
RESTRICT="nostrip"
# force debug information
CFLAGS="${CFLAGS} -g"
CXXFLAGS="${CXXFLAGS} -g"


S=${WORKDIR}/${P}
DESCRIPTION="Gimp ToolKit + "
SRC_URI="ftp://ftp.gtk.org/pub/gtk/v2.0/${P}.tar.bz2
	directfb? ( mirror://gentoo//gtk+-directfb-2.0.5-gentoo.patch.bz2 )"
HOMEPAGE="http://www.gtk.org/"
LICENSE="LGPL-2.1"

RDEPEND="virtual/x11
	>=dev-libs/glib-2.0.4
	>=dev-libs/atk-1.0.2
	>=x11-libs/pango-1.0.3
	>=media-libs/libpng-1.2.1
	jpeg? ( >=media-libs/jpeg-6b-r2 )
	tiff? ( >=media-libs/tiff-3.5.7 )
	directfb? ( dev-libs/DirectFB )"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0
	 doc? ( >=dev-util/gtk-doc-0.9 )"

src_unpack() {
	
	unpack ${P}.tar.bz2
	use directfb && ( \
		cd ${S}
		bzcat ${DISTDIR}/${PN}-directfb-${PV}-gentoo.patch.bz2 | patch -p1
	)
}

src_compile() {
	elibtoolize
	
	local myconf=""
	use doc && myconf="${myconf} --enable-gtk-doc" || myconf="${myconf} --disable-gtk-doc"
	use jpeg ||  myconf="${myconf} --without-libjpeg"
	use tiff ||  myconf="${myconf} --without-libtiff"
	
	./configure --host=${CHOST} \
		--prefix=/usr \
		--sysconfdir=/etc \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		--with-gdktarget=x11 \
		${myconf} \
		--enable-debug || die
# enable debug since glib fails if we disable it

# gtk+ isn't multithread friendly due to some obscure code generation bug
#	make || die
}

src_install() {
	dodir /etc/gtk-2.0
	make DESTDIR=${D} \
		prefix=/usr \
		sysconfdir=/etc \
		infodir=/usr/share/info \
		mandir=/usr/share/man \
		install || die
	dodoc AUTHORS COPYING ChangeLog* HACKING* INSTALL NEWS* README* TODO
}


pkg_postinst() {
	gtk-query-immodules-2.0 >	/etc/gtk-2.0/gtk.immodules
}

