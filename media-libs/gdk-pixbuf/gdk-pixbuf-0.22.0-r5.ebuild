# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/gdk-pixbuf/gdk-pixbuf-0.22.0-r5.ebuild,v 1.5 2006/10/16 23:23:31 blubb Exp $

inherit virtualx libtool gnome.org eutils

DESCRIPTION="GNOME Image Library"
HOMEPAGE="http://www.gtk.org/"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 sh sparc x86"
IUSE="doc mmx"

RDEPEND="media-libs/jpeg
	media-libs/tiff
	=x11-libs/gtk+-1.2*
	>=media-libs/libpng-1.2.1
	amd64? ( sys-libs/db )
	!amd64? ( <sys-libs/db-2 )
	>=gnome-base/gnome-libs-1.4.1.2-r1"
# We need gnome-libs here, else gnome support do not get compiled into
# gdk-pixbuf (the GnomeCanvasPixbuf library )
DEPEND="${RDEPEND}
	doc? ( dev-util/gtk-doc )"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${P}-m4.patch
	# security fix (#64230)
	epatch "${FILESDIR}"/${P}-bmp_secure.patch
	epatch "${FILESDIR}"/${P}-loaders.patch
	# reject corrupt bmps (#64230)
	epatch "${FILESDIR}"/${P}-bmp_reject_corrupt.patch

	# update libtool, else we get the "relink bug"
	elibtoolize
}

src_compile() {
	econf \
		--sysconfdir=/etc/X11/gdk-pixbuf \
		$(use_enable doc gtk-doc) \
		$(use_enable mmx) \
		|| die

	# build needs to be able to
	# connect to an X display.
	Xemake || die
}

src_install() {
	einstall \
		sysconfdir="${D}"/etc/X11/gdk-pixbuf || die

	dosed -e "s:${D}::g" /usr/bin/gdk-pixbuf-config
	# fix permissions on the loaders
	chmod a+rx "${D}"/usr/$(get_libdir)/gdk-pixbuf/loaders
	chmod a+r "${D}"/usr/$(get_libdir)/gdk-pixbuf/loaders/*

	dodoc AUTHORS ChangeLog INSTALL README NEWS TODO
}
