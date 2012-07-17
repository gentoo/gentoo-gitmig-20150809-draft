# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/simple-scan/simple-scan-3.2.1.ebuild,v 1.5 2012/07/17 06:37:00 tetromino Exp $

EAPI="4"

GCONF_DEBUG="no"

inherit gnome2

DESCRIPTION="Simple document scanning utility"
HOMEPAGE="https://launchpad.net/simple-scan"
SRC_URI="http://launchpad.net/${PN}/trunk/${PV}/+download/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

COMMON_DEPEND="
	>=dev-libs/glib-2.28:2
	>=media-gfx/sane-backends-1.0.20
	virtual/jpeg
	|| ( >=sys-fs/udev-171[gudev] >=sys-fs/udev-145[extras] )
	>=sys-libs/zlib-1.2.3.1
	x11-libs/cairo
	>=x11-libs/gtk+-3:3
	x11-misc/colord[scanner]
"
RDEPEND="${COMMON_DEPEND}
	x11-misc/xdg-utils
	x11-themes/gnome-icon-theme"
DEPEND="${COMMON_DEPEND}
	app-text/gnome-doc-utils
	dev-lang/vala:0.14
	gnome-base/gnome-common
	>=dev-util/intltool-0.35.0
	virtual/pkgconfig"

pkg_setup() {
	DOCS="AUTHORS ChangeLog NEWS README"
	G2CONF="${G2CONF} VALAC=$(type -p valac-0.14)"
}
