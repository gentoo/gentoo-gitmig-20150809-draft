# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/gtk+/gtk+-2.2.1-r1.ebuild,v 1.1 2003/04/11 14:19:57 foser Exp $

inherit eutils libtool flag-o-matic

IUSE="tiff doc jpeg"
SLOT="2"
KEYWORDS="~x86 ~ppc ~alpha ~sparc"

S="${WORKDIR}/${P}"
DESCRIPTION="Gimp ToolKit + "
SRC_URI="ftp://ftp.gtk.org/pub/gtk/v2.2/${P}.tar.bz2"
HOMEPAGE="http://www.gtk.org/"
LICENSE="LGPL-2.1"

RDEPEND="virtual/x11
	>=dev-libs/glib-2.2.0
	>=dev-libs/atk-1.2.0
	>=x11-libs/pango-1.1.3
	>=media-libs/libpng-1.2.1
	jpeg? ( >=media-libs/jpeg-6b-r2 )
	tiff? ( >=media-libs/tiff-3.5.7 )"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0
	doc? ( >=dev-util/gtk-doc-0.9 )"

src_unpack() {
	unpack ${A}

	# Turn of --export-symbols-regex for now, since it removes
	# the wrong symbols
	cd ${S}; epatch ${FILESDIR}/gtk+-2.0.6-exportsymbols.patch
	# should speed up metacity
	cd ${S}; epatch ${FILESDIR}/gtk+-wm.patch
	# beautifying patch for disabled icons
	epatch ${FILESDIR}/${P}-disable_icons_smooth_alpha.patch
	# fixing expose loops in GtkTreeView (gnome #106311)
	epatch ${FILESDIR}/${P}-scrollfix.patch

	if [ "${ARCH}" == "ppc" ]
	then
		einfo "Fixing endianness issue in gdkpixbuf for 24-bit and 15-bit displays"
		cd ${S}; epatch ${FILESDIR}/gtk+-2.2.1-gdkpixbuf-bigendian.patch
	fi
}

src_compile() {
	# bug 8762
	replace-flags "-O3" "-O2"

	elibtoolize
	
	local myconf=""
	use doc && myconf="${myconf} --enable-gtk-doc" || myconf="${myconf} --disable-gtk-doc"
	use jpeg ||  myconf="${myconf} --without-libjpeg"
	use tiff ||  myconf="${myconf} --without-libtiff"
	if [ -n "$DEBUGBUILD" ]; then
		myconf="${myconf}  --enable-debug"
	fi
		
	econf --with-gdktarget=x11 ${myconf} || die

	# gtk+ isn't multithread friendly due to some obscure code generation bug
	make || die
}

src_install() {
	dodir /etc/gtk-2.0

	make DESTDIR=${D} \
		prefix=/usr \
		sysconfdir=/etc \
		infodir=/usr/share/info \
		mandir=/usr/share/man \
		install || die

	dodoc AUTHORS COPYING ChangeLog* HACKING INSTALL NEWS* README*
}

pkg_postinst() {
	gtk-query-immodules-2.0 >	/etc/gtk-2.0/gtk.immodules
	gdk-pixbuf-query-loaders >	/etc/gtk-2.0/gdk-pixbuf.loaders

	einfo "For your gtk themes to work correctly after an update," 
	einfo "you might have to rebuild your theme engines."
	einfo "Executing 'qpkg -I -nc gtk-engines | xargs emerge' should do the trick (requires gentoolkit)"
}
