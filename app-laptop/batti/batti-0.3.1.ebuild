# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-laptop/batti/batti-0.3.1.ebuild,v 1.2 2010/04/13 13:18:23 idl0r Exp $

EAPI=2

PYTHON_DEPEND="2:2.6"

inherit distutils gnome2-utils

DESCRIPTION="A upower based battery monitor for the system tray, similar to batterymon"
HOMEPAGE="http://code.google.com/p/batti-gtk/"
SRC_URI="http://batti-gtk.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="libnotify"

RDEPEND="dev-python/pygtk
	dev-python/dbus-python
	sys-power/upower
	libnotify? ( x11-libs/libnotify )"
DEPEND="${RDEPEND}
	dev-python/python-distutils-extra"

pkg_setup() {
	DOCS="AUTHORS"
	python_set_active_version 2
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	gnome2_icon_cache_update
	distutils_pkg_postinst

	echo
	ewarn "Remember, in order to use batti, you have to"
	ewarn "be in the 'messagebus' group."
	echo
	ewarn "Just run 'gpasswd -a <USER> messagebus', then have <USER> re-login."
	echo
}

pkg_postrm() {
	gnome2_icon_cache_update
	distutils_pkg_postrm
}
