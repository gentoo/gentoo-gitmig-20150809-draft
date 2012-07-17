# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/simple-scan/simple-scan-2.32.0.2.ebuild,v 1.6 2012/07/17 06:37:00 tetromino Exp $

EAPI=3

GCONF_DEBUG="no"

inherit gnome2

DESCRIPTION="Simple document scanning utility"
HOMEPAGE="https://launchpad.net/simple-scan"
SRC_URI="http://launchpad.net/${PN}/trunk/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

COMMON_DEPEND="
	>=x11-libs/gtk+-2.18.0:2
	dev-libs/glib:2
	gnome-base/gconf:2
	>=media-gfx/sane-backends-1.0.20
	virtual/jpeg
	|| ( >=sys-fs/udev-171[gudev] >=sys-fs/udev-145[extras] )
	>=sys-libs/zlib-1.2.3.1
	x11-libs/cairo"
RDEPEND="${COMMON_DEPEND}
	x11-misc/xdg-utils
	x11-themes/gnome-icon-theme"
DEPEND="${COMMON_DEPEND}
	app-text/gnome-doc-utils
	>=dev-util/intltool-0.35.0
	virtual/pkgconfig"

DOCS="AUTHORS ChangeLog NEWS README"
