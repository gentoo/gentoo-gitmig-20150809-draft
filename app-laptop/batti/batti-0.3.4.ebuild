# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-laptop/batti/batti-0.3.4.ebuild,v 1.1 2010/04/16 14:12:51 idl0r Exp $

EAPI=3

PYTHON_SUPPORT_ABIS="1"
PYTHON_DEPEND="2:2.6"
RESTRICT_PYTHON_ABIS="3.*"

inherit python distutils gnome2-utils

DESCRIPTION="A upower based battery monitor for the system tray, similar to batterymon"
HOMEPAGE="http://code.google.com/p/batti-gtk/"
SRC_URI="http://batti-gtk.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="libnotify"

RDEPEND="dev-python/pygtk
	dev-python/dbus-python
	|| ( sys-apps/devicekit-power sys-power/upower )
	libnotify? ( x11-libs/libnotify )"
DEPEND=""

pkg_setup() {
	DOCS="AUTHORS"
	python_set_active_version 2
}

src_prepare() {
	distutils_src_prepare
	python_convert_shebangs 2 batti
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	gnome2_icon_cache_update
	distutils_pkg_postinst
}

pkg_postrm() {
	gnome2_icon_cache_update
	distutils_pkg_postrm
}
