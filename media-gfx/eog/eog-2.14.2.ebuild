# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/eog/eog-2.14.2.ebuild,v 1.11 2006/10/20 23:56:50 agriffis Exp $

inherit eutils gnome2 autotools

DESCRIPTION="Eye Of Gnome, an image viewer"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2"
SLOT="1"
KEYWORDS="alpha amd64 ~arm hppa ia64 ppc ppc64 sparc x86"
IUSE="jpeg lcms"

RDEPEND=">=gnome-base/gnome-vfs-2.5.91
	>=gnome-base/libgnomeui-2.5.92
	>=gnome-base/libglade-2.3.6
	>=x11-libs/gtk+-2.7.1
	>=gnome-base/libgnomecanvas-2.5.92
	>=gnome-base/gconf-2.5.90
	>=media-libs/libart_lgpl-2.3.16
	>=gnome-base/libgnomeprintui-2.2
	>=gnome-base/libgnomeprint-2.2
	>=gnome-base/gnome-desktop-2.10
	dev-libs/popt
	>=gnome-base/gnome-common-2.12.0
	jpeg? (
		>=media-libs/libexif-0.6.12
		media-libs/jpeg )
	lcms? ( media-libs/lcms )"

DEPEND="${RDEPEND}
	app-text/scrollkeeper
	>=dev-util/intltool-0.34
	>=dev-util/pkgconfig-0.17"

DOCS="AUTHORS ChangeLog HACKING MAINTAINERS NEWS README THANKS TODO"

pkg_setup() {
	G2CONF="${G2CONF} $(use_with jpeg libjpeg) \
		$(use_with jpeg libexif) \
		$(use_with lcms cms)"
}

src_unpack() {
	gnome2_src_unpack

	# Fix pkg-config detection if --without-libexif is passed.
	epatch ${FILESDIR}/${PN}-2.11.90-pkgconfig_macro.patch

	eautoreconf
}
