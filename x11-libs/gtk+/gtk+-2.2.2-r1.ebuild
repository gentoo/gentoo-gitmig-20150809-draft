# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/gtk+/gtk+-2.2.2-r1.ebuild,v 1.4 2003/07/02 18:16:49 weeve Exp $

inherit eutils libtool flag-o-matic

IUSE="tiff doc jpeg debug"
SLOT="2"
KEYWORDS="~x86 ~ppc ~alpha ~sparc"

DESCRIPTION="Gimp ToolKit + "
SRC_URI="ftp://ftp.gtk.org/pub/gtk/v2.2/${P}.tar.bz2"
HOMEPAGE="http://www.gtk.org/"
LICENSE="LGPL-2.1"

# virtual/x11
# Need this specific xfree version to get bugfree xinput support (#20407)

RDEPEND=">=x11-base/xfree-4.3.0-r3
	>=dev-libs/glib-2.2
	>=dev-libs/atk-1.2
	>=x11-libs/pango-1.2
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
	epatch ${FILESDIR}/${PN}-2.2.1-disable_icons_smooth_alpha.patch
	# xft/slighthint stuff from RH
	cd ${S}; epatch ${FILESDIR}/${PN}-2-xftprefs.patch
	# fix for problem described in #22576
	epatch ${FILESDIR}/${P}-gtkwidget_pixmap_expose.patch

	autoconf || die
}

src_compile() {
	# bug 8762
	replace-flags "-O3" "-O2"

	elibtoolize
	
	local myconf=""

	use doc \
		&& myconf="${myconf} --enable-gtk-doc" \
		|| myconf="${myconf} --disable-gtk-doc"
	use png \
		&& myconf="${myconf} --with-libpng" \
		||  myconf="${myconf} --without-libpng"
	use jpeg \
		&& myconf="${myconf} --with-libjpeg" \
		||  myconf="${myconf} --without-libjpeg"
	use tiff \
		&& myconf="${myconf} --with-libtiff" \
		||  myconf="${myconf} --without-libtiff"
	use debug \
		&& myconf="${myconf}  --enable-debug" \
		|| myconf="${myconf}  --disable-debug"
		
	econf --with-gdktarget=x11 --with-xinput=yes ${myconf} || die

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

	# Enable xft in environment as suggested by <utx@gentoo.org>
	dodir /etc/env.d
	echo "GDK_USE_XFT=1" >${D}/etc/env.d/50gtk2

	dodoc AUTHORS COPYING ChangeLog* HACKING INSTALL NEWS* README*
}

pkg_postinst() {
	gtk-query-immodules-2.0 >	/etc/gtk-2.0/gtk.immodules
	gdk-pixbuf-query-loaders >	/etc/gtk-2.0/gdk-pixbuf.loaders

	einfo "For your gtk themes to work correctly after an update," 
	einfo "you might have to rebuild your theme engines."
	einfo "Executing 'qpkg -I -nc gtk-engines | xargs emerge' should do the trick (requires gentoolkit)"

	env-update
}

pkg_postrm() {
	env-update
}
