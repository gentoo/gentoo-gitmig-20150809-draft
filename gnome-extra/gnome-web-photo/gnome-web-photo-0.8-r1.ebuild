# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-web-photo/gnome-web-photo-0.8-r1.ebuild,v 1.1 2010/02/08 17:44:15 mrpouet Exp $

inherit autotools gnome2

DESCRIPTION="a tool to generate images and thumbnails from HTML files"
HOMEPAGE="ftp://ftp.gnome.org/pub/gnome/sources/gnome-web-photo"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="jpeg"

RDEPEND=">=dev-libs/glib-2.6.0
		>=x11-libs/gtk+-2.6.3
		>=dev-libs/libxml2-2.6.12
		>=gnome-base/gnome-vfs-2.9.2
		media-libs/libpng
		gnome-base/gconf
		jpeg? ( media-libs/jpeg )
		net-libs/xulrunner"
DEPEND="${RDEPEND}
		>=dev-util/pkgconfig-0.19"

DOCS="AUTHORS ChangeLog HACKING NEWS README TODO"

pkg_setup() {
	G2CONF="${G2CONF} $(use_enable jpeg)"
}
src_unpack() {
	gnome2_src_unpack

	# Compatibility with xulrunner-1.9.2, per bug #303897
	epatch "${FILESDIR}"/${P}-libxul-compat.patch
	eautoreconf
}
