# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/gtk+/gtk+-2.2.4-r1.ebuild,v 1.14 2004/03/30 05:22:29 spyderous Exp $

inherit eutils libtool flag-o-matic

DESCRIPTION="Gimp ToolKit +"
HOMEPAGE="http://www.gtk.org/"
SRC_URI="ftp://ftp.gtk.org/pub/gtk/v2.2/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="2"
KEYWORDS="x86 ppc alpha sparc amd64 hppa ia64 ~mips"
IUSE="doc tiff jpeg"

RDEPEND="virtual/x11
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

	cd ${S}
	# Turn of --export-symbols-regex for now, since it removes
	# the wrong symbols
	epatch ${FILESDIR}/gtk+-2.0.6-exportsymbols.patch
	# should speed up metacity
	epatch ${FILESDIR}/gtk+-wm.patch
	# beautifying patch for disabled icons
	epatch ${FILESDIR}/${PN}-2.2.1-disable_icons_smooth_alpha.patch
	# xft/slighthint stuff from RH
	epatch ${FILESDIR}/${PN}-2-xftprefs.patch
	# notification area loop fix (http://bugs.gnome.org/show_bug.cgi?id=122327)
	# submitted by <pat@engsoc.org>
	epatch ${FILESDIR}/${PN}-2.2-notificationarea_loop.patch

	autoconf || die
}

src_compile() {
	# bug 8762
	replace-flags "-O3" "-O2"

	elibtoolize

	econf \
		`use_enable doc gtk-doc` \
		`use_with jpeg libjpeg` \
		`use_with tiff libtiff` \
		--with-gdktarget=x11 \
		--with-xinput=xfree \
		|| die

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
