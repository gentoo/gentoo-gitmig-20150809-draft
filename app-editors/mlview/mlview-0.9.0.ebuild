# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/mlview/mlview-0.9.0.ebuild,v 1.4 2010/06/27 14:13:08 nixnut Exp $

EAPI=2
inherit eutils gnome2

DESCRIPTION="XML editor for the GNOME environment"
HOMEPAGE="http://www.freespiders.org/projects/gmlview/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ~x86 ~x86-interix ~amd64-linux ~x86-linux"
IUSE="debug"

RDEPEND=">=dev-libs/libxml2-2.6.11
	>=dev-libs/libxslt-1.1.8
	>=dev-libs/glib-2.6:2
	>=x11-libs/gtk+-2.6:2
	>=dev-cpp/gtkmm-2.4
	>=gnome-base/libglade-2.4
	>=dev-cpp/libglademm-2.6
	>=gnome-base/libgnome-2.8.1
	>=gnome-base/gnome-vfs-2.6
	>=gnome-base/libgnomeui-2.2
	>=gnome-base/gconf-2.6.2
	=x11-libs/gtksourceview-1*
	>=x11-libs/vte-0.11.12
	sys-libs/zlib"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool
	sys-devel/gettext"

pkg_setup() {
	DOCS="AUTHORS BRANCHES ChangeLog NEWS README"
	G2CONF="--disable-dependency-tracking
		--disable-static
		$(use_enable debug)"
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-desktop.patch \
		"${FILESDIR}"/${P}-gcc44.patch \
		"${FILESDIR}"/${P}-gcc45.patch
	gnome2_src_prepare
}

src_install() {
	gnome2_src_install
	find "${D}" -name '*.la' -exec rm -f {} +
}
