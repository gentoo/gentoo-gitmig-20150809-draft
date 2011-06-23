# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/shotwell/shotwell-0.10.1.ebuild,v 1.1 2011/06/23 10:37:01 angelos Exp $

EAPI=4
inherit gnome2 versionator eutils multilib toolchain-funcs

MY_PV=$(get_version_component_range 1-2)
DESCRIPTION="Open source photo manager for GNOME"
HOMEPAGE="http://www.yorba.org/shotwell/"
SRC_URI="http://www.yorba.org/download/${PN}/${MY_PV}/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-db/sqlite-3.5.9:3
	>=dev-libs/dbus-glib-0.80
	>=dev-libs/json-glib-0.7.6
	>=dev-libs/libgee-0.5.0
	>=dev-libs/libunique-1:1
	>=dev-libs/libxml2-2.6.32:2
	>=gnome-base/gconf-2.22.0:2
	>=media-libs/gexiv2-0.2.0
	media-libs/gstreamer:0.10
	media-libs/lcms:2
	>=media-libs/libexif-0.6.16
	>=media-libs/libgphoto2-2.4.2
	>=media-libs/libraw-0.9.0
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
		--disable-schemas-install
		--disable-desktop-update
		--disable-icon-update
		--lib=$(get_libdir)"
}

src_prepare() {
	epatch "${FILESDIR}"/0.10-ldflags.patch
	gnome2_src_prepare

	sed -e 's/valac/valac-0.12/' -i plugins/Makefile.plugin.mk || die
	sed -e 's/valac/valac-0.12/' -i Makefile || die
}

src_install() {
	# This is needed so that gnome2_gconf_savelist() works correctly.
	insinto /etc/gconf/schemas
	doins misc/shotwell.schemas || die "install gconf schema failed"
	gnome2_src_install
}
