# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/gtk+/gtk+-2.6.10-r1.ebuild,v 1.7 2007/11/13 02:45:01 leio Exp $

inherit flag-o-matic eutils

DESCRIPTION="Gimp ToolKit +"
HOMEPAGE="http://www.gtk.org/"
SRC_URI="ftp://ftp.gtk.org/pub/gtk/v2.6/${P}.tar.bz2
	mirror://gentoo/gtk+-2.6-smoothscroll-r5.patch.bz2
	amd64? ( http://dev.gentoo.org/~kingtaco/gtk+-2.6.1-lib64.patch.bz2 )"

LICENSE="LGPL-2"
SLOT="2"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 sparc x86"
IUSE="doc tiff jpeg"

RDEPEND="x11-libs/libXrender
	x11-libs/libX11
	x11-libs/libXi
	x11-libs/libXt
	x11-libs/libXext
	x11-libs/libXinerama
	x11-libs/libXcursor
	x11-libs/libXrandr
	x11-libs/libXfixes
	>=dev-libs/glib-2.6
	>=dev-libs/atk-1.0.1
	>=x11-libs/pango-1.8
	x11-misc/shared-mime-info
	>=media-libs/libpng-1.2.1
	jpeg? ( >=media-libs/jpeg-6b-r2 )
	tiff? ( >=media-libs/tiff-3.5.7 )"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9
	sys-devel/autoconf
	>=sys-devel/automake-1.7.9
	x11-proto/xextproto
	x11-proto/xproto
	x11-proto/inputproto
	x11-proto/xineramaproto
	doc? ( >=dev-util/gtk-doc-1 )"

set_gtk2_confdir() {
	# An arch specific config directory is used on multilib systems
	has_multilib_profile && GTK2_CONFDIR="/etc/gtk-2.0/${CHOST}"
	use x86 && [ "$(get_libdir)" == "lib32" ] && GTK2_CONFDIR="/etc/gtk-2.0/${CHOST}"
	GTK2_CONFDIR=${GTK2_CONFDIR:=/etc/gtk-2.0}
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Fix problems in gdk-pixbuf's code regarding XPM files. Bug #112608.
	epatch "${FILESDIR}"/${PN}-2-xpm_loader.patch
	# beautifying patch for disabled icons
	epatch "${FILESDIR}"/${PN}-2.2.1-disable_icons_smooth_alpha.patch
	# add smoothscroll support for usability reasons
	# http://bugzilla.gnome.org/show_bug.cgi?id=103811
	epatch "${DISTDIR}"/${PN}-2.6-smoothscroll-r5.patch.bz2

	# use an arch-specific config directory so that 32bit and 64bit versions
	# dont clash on multilib systems
	has_multilib_profile && epatch ${DISTDIR}/gtk+-2.6.1-lib64.patch.bz2
	# and this line is just here to make building emul-linux-x86-gtklibs a bit
	# easier, so even this should be amd64 specific.
	use x86 && [ "$(get_libdir)" == "lib32" ] && epatch ${DISTDIR}/gtk+-2.6.1-lib64.patch.bz2

	# patch for ppc64 (#64359,#109089)
	use ppc64 && ! has_version '>=dev-libs/glib-2.8' && epatch "${FILESDIR}/${PN}-2.4.9-ppc64.patch"
	use ppc64 && append-flags -mminimal-toc

	autoconf || die "autoconf failed"
	automake || die "automake failed"

	epunt_cxx
}

src_compile() {

	# bug 8762
	replace-flags "-O3" "-O2"

	econf \
		`use_enable doc gtk-doc` \
		`use_with jpeg libjpeg` \
		`use_with tiff libtiff` \
		--with-libpng \
		--with-gdktarget=x11 \
		--with-xinput \
		|| die

	# gtk+ isn't multithread friendly due to some obscure code generation bug
	emake -j1 || die "Compilation failed"

}

src_install() {
	set_gtk2_confdir
	dodir ${GTK2_CONFDIR}
	keepdir ${GTK2_CONFDIR}

	make DESTDIR="${D}" install || die "Installation failed"

	# Enable xft in environment as suggested by <utx@gentoo.org>
	dodir /etc/env.d
	echo "GDK_USE_XFT=1" >"${D}/etc/env.d/50gtk2"

	dodoc AUTHORS ChangeLog* HACKING NEWS* README*
}

pkg_postinst() {
	set_gtk2_confdir

	gtk-query-immodules-2.0  > "${ROOT}${GTK2_CONFDIR}/gtk.immodules"
	gdk-pixbuf-query-loaders > "${ROOT}${GTK2_CONFDIR}/gdk-pixbuf.loaders"
}
