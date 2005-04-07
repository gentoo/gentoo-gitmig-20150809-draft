# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/gtk+/gtk+-2.4.14.ebuild,v 1.8 2005/04/07 15:30:33 blubb Exp $

inherit libtool flag-o-matic eutils

DESCRIPTION="Gimp ToolKit +"
HOMEPAGE="http://www.gtk.org/"
SRC_URI="ftp://ftp.gtk.org/pub/gtk/v2.4/${P}.tar.bz2
	mirror://gentoo/gtk+-2.4-smoothscroll-r1.patch
	amd64? ( http://dev.gentoo.org/~lv/gtk+-2.4.1-lib64.patch.bz2 )"

LICENSE="LGPL-2"
SLOT="2"
KEYWORDS="x86 ppc sparc ~mips alpha arm hppa amd64 ia64 ~ppc64"
IUSE="doc tiff jpeg"

RDEPEND="virtual/x11
	>=dev-libs/glib-2.4
	>=dev-libs/atk-1.0.1
	>=x11-libs/pango-1.4
	x11-misc/shared-mime-info
	>=media-libs/libpng-1.2.1
	jpeg? ( >=media-libs/jpeg-6b-r2 )
	tiff? ( >=media-libs/tiff-3.5.7 )"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0
	sys-devel/autoconf
	>=sys-devel/automake-1.7.9
	doc? ( >=dev-util/gtk-doc-1 )"

src_unpack() {

	unpack ${A}

	cd ${S}
	# Turn of --export-symbols-regex for now, since it removes
	# the wrong symbols
	epatch ${FILESDIR}/gtk+-2.0.6-exportsymbols.patch
	# beautifying patch for disabled icons
	epatch ${FILESDIR}/${PN}-2.2.1-disable_icons_smooth_alpha.patch
	# add smoothscroll support for usability reasons
	# http://bugzilla.gnome.org/show_bug.cgi?id=103811
	epatch ${DISTDIR}/${PN}-2.4-smoothscroll-r1.patch

	# use an arch-specific config directory so that 32bit and 64bit versions
	# dont clash on multilib systems
	use amd64 && epatch ${DISTDIR}/gtk+-2.4.1-lib64.patch.bz2
	# and this line is just here to make building emul-linux-x86-gtklibs a bit
	# easier, so even this should be amd64 specific.
	use x86 && [ "${CONF_LIBDIR}" == "lib32" ] && epatch ${DISTDIR}/gtk+-2.4.1-lib64.patch.bz2
	# patch for ppc64 (#64359)
	use ppc64 && epatch ${FILESDIR}/${PN}-2.4.9-ppc64.patch

	autoconf || die
	automake || die

}

src_compile() {

	# bug 8762
	replace-flags "-O3" "-O2"

	elibtoolize

	econf \
		`use_enable doc gtk-doc` \
		`use_with jpeg libjpeg` \
		`use_with tiff libtiff` \
		--with-png \
		--with-gdktarget=x11 \
		--with-xinput \
		|| die

	# gtk+ isn't multithread friendly due to some obscure code generation bug
	MAKEOPTS="${MAKEOPTS} -j1" emake || die

}

src_install() {

	dodir /etc/gtk-2.0
	use amd64 && dodir /etc/gtk-2.0/${CHOST}
	use x86 && [ "${CONF_LIBDIR}" == "lib32" ] && dodir /etc/gtk-2.0/${CHOST}

	make DESTDIR=${D} install || die

	# Enable xft in environment as suggested by <utx@gentoo.org>
	dodir /etc/env.d
	echo "GDK_USE_XFT=1" >${D}/etc/env.d/50gtk2

	dodoc AUTHORS ChangeLog* HACKING NEWS* README*

}

pkg_postinst() {

	use amd64 && GTK2_CONFDIR="/etc/gtk-2.0/${CHOST}"
	use x86 && [ "${CONF_LIBDIR}" == "lib32" ] && GTK2_CONFDIR="/etc/gtk-2.0/${CHOST}"
	GTK2_CONFDIR=${GTK2_CONFDIR:=/etc/gtk-2.0/}

	gtk-query-immodules-2.0 >	/${GTK2_CONFDIR}/gtk.immodules
	gdk-pixbuf-query-loaders >	/${GTK2_CONFDIR}/gdk-pixbuf.loaders

}
