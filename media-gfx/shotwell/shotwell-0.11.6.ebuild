# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/shotwell/shotwell-0.11.6.ebuild,v 1.1 2011/11/11 16:20:30 angelos Exp $

EAPI=4
GCONF_DEBUG="no"
inherit gnome2 versionator eutils multilib toolchain-funcs

MY_PV=$(get_version_component_range 1-2)
DESCRIPTION="Open source photo manager for GNOME"
HOMEPAGE="http://www.yorba.org/shotwell/"
SRC_URI="http://www.yorba.org/download/${PN}/${MY_PV}/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	>=dev-db/sqlite-3.5.9:3
	>=dev-libs/dbus-glib-0.80
	>=dev-libs/json-glib-0.7.6
	>=dev-libs/libgee-0.5.0:0
	>=dev-libs/libunique-1:1
	>=dev-libs/libxml2-2.6.32:2
	>=gnome-base/gconf-2.22.0:2
	>=media-libs/gexiv2-0.2.0
	media-libs/gstreamer:0.10
	media-libs/lcms:2
	>=media-libs/libexif-0.6.16
	>=media-libs/libgphoto2-2.4.2
	>=media-libs/libraw-0.14.0
	>=net-libs/libsoup-2.26.0:2.4
	>=net-libs/webkit-gtk-1.1.5:2
	|| ( >=sys-fs/udev-171[gudev] >=sys-fs/udev-145[extras] )
	>=x11-libs/gtk+-2.18.0:2"
DEPEND="${RDEPEND}
	>=dev-lang/vala-0.11.7:0.12"

DOCS=( AUTHORS MAINTAINERS NEWS README THANKS )

pkg_setup() {
	tc-export CC
	G2CONF="${G2CONF}
		--disable-schemas-compile
		--disable-desktop-update
		--disable-icon-update
		--lib=$(get_libdir)"
}

src_prepare() {
	epatch "${FILESDIR}"/${PN}-0.11.2-libraw-0.14.patch
}

src_compile() {
	emake VALAC="$(type -p valac-0.12)"
}
