# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/colord-gtk/colord-gtk-0.1.22-r1.ebuild,v 1.1 2012/08/26 02:08:12 tetromino Exp $

EAPI="4"

inherit autotools eutils

DESCRIPTION="GTK support library for colord"
HOMEPAGE="http://www.freedesktop.org/software/colord/"
SRC_URI="http://www.freedesktop.org/software/colord/releases/${P}.tar.xz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~mips ~ppc ~ppc64 ~x86 ~x86-fbsd"
IUSE="doc +introspection vala"
REQUIRED_USE="vala? ( introspection )"

COMMON_DEPEND=">=dev-libs/glib-2.28:2
	>=media-libs/lcms-2.2:2
	x11-libs/gdk-pixbuf:2[introspection?]
	x11-libs/gtk+:3[X(+),introspection?]
	x11-misc/colord[introspection?,vala?]
	introspection? ( >=dev-libs/gobject-introspection-0.9.8 )"
# ${PN} was part of x11-misc/colord until 0.1.22
RDEPEND="${COMMON_DEPEND}
	!<x11-misc/colord-0.1.22"
DEPEND="${COMMON_DEPEND}
	app-arch/xz-utils
	dev-libs/libxslt
	>=dev-util/intltool-0.35
	>=sys-devel/gettext-0.17
	virtual/pkgconfig
	doc? (
		app-text/docbook-xml-dtd:4.1.2
		>=dev-util/gtk-doc-1.9
	)
	vala? ( dev-lang/vala:0.14[vapigen] )"

RESTRICT="test" # Tests need a display device with a default color profile set

src_prepare() {
	epatch "${FILESDIR}/${PN}-0.1.22-automagic-vala.patch"
	# Fix include guards, in next release
	epatch "${FILESDIR}/${P}-includes-"{1,2}.patch
	eautoreconf
}

src_configure() {
	econf \
		--disable-static \
		$(use_enable doc gtk-doc) \
		$(use_enable introspection) \
		$(use_enable vala) \
		VAPIGEN=$(type -P vapigen-0.14)
}

src_install() {
	default
	prune_libtool_files
}
