# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-web-photo/gnome-web-photo-0.9.ebuild,v 1.5 2010/11/08 22:49:40 eva Exp $

EAPI="2"

inherit autotools gnome2

DESCRIPTION="a tool to generate images and thumbnails from HTML files"
HOMEPAGE="ftp://ftp.gnome.org/pub/gnome/sources/gnome-web-photo"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="jpeg"

RDEPEND=">=dev-libs/glib-2.6
	>=x11-libs/gtk+-2.6.3
	>=dev-libs/libxml2-2.6.12
	media-libs/libpng
	gnome-base/gconf
	jpeg? ( virtual/jpeg )
	>=net-libs/xulrunner-1.9.2"
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
