# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-web-photo/gnome-web-photo-0.9.ebuild,v 1.7 2011/11/06 06:09:27 tetromino Exp $

EAPI="2"

inherit autotools gnome2

DESCRIPTION="A tool to generate images and thumbnails from HTML files"
HOMEPAGE="http://git.gnome.org/browse/gnome-web-photo/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="jpeg"

RDEPEND=">=dev-libs/glib-2.6:2
	>=x11-libs/gtk+-2.6.3:2
	>=dev-libs/libxml2-2.6.12:2
	media-libs/libpng:0
	gnome-base/gconf:2
	jpeg? ( virtual/jpeg:0 )
	>=net-libs/xulrunner-1.9.2:1.9"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.19
	sys-devel/gettext"

DOCS="AUTHORS ChangeLog HACKING NEWS README TODO"

pkg_setup() {
	G2CONF="${G2CONF} $(use_enable jpeg)"
}

src_prepare() {
	gnome2_src_prepare

	# Compatibility with xulrunner-1.9.2, per bug #303897
	epatch "${FILESDIR}/${PN}-0.8-libxul-compat.patch"

	eautoreconf
}
