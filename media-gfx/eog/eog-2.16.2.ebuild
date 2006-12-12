# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/eog/eog-2.16.2.ebuild,v 1.3 2006/12/12 16:52:16 wolf31o2 Exp $

inherit eutils gnome2 autotools

DESCRIPTION="Eye Of Gnome, an image viewer"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2"
SLOT="1"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc x86"
IUSE="jpeg lcms"

RDEPEND=">=gnome-base/gnome-vfs-2.5.91
	>=gnome-base/libgnomeui-2.5.92
	>=gnome-base/libglade-2.3.6
	>=gnome-base/libgnomecanvas-2.5.92
	>=gnome-base/gconf-2.5.90
	>=media-libs/libart_lgpl-2.3.16
	>=x11-libs/gtk+-2.7.1
	>=gnome-base/gnome-desktop-2.10
	>=gnome-base/libgnomeprintui-2.2
	>=gnome-base/libgnomeprint-2.2
	jpeg? (
		>=media-libs/libexif-0.6.12
		media-libs/jpeg )
	lcms? ( media-libs/lcms )"

DEPEND="${RDEPEND}
	app-text/scrollkeeper
	>=dev-util/intltool-0.35
	>=dev-util/pkgconfig-0.17
	>=gnome-base/gnome-common-2.12.0
	>=app-text/gnome-doc-utils-0.3.2"
# gnome-common and gnome-doc-utils only necessary with eautoreconf

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
