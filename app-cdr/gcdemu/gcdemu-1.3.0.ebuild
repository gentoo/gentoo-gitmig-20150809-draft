# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/gcdemu/gcdemu-1.3.0.ebuild,v 1.6 2011/12/31 21:24:32 tetromino Exp $

EAPI="3"

PYTHON_DEPEND="2"

inherit python gnome2

DESCRIPTION="Gtk+ GUI for controlling the CDEmu daemon (cdemud)"
HOMEPAGE="http://cdemu.org/"
SRC_URI="mirror://sourceforge/cdemu/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="libnotify"

COMMON_DEPEND=">=dev-python/pygtk-2.6
	>=dev-python/pygobject-2.6:2
	>=dev-python/libgnome-python-2.6
	>=dev-python/gnome-applets-python-2.6
	dev-python/gconf-python
	>=dev-python/dbus-python-0.71
	>=app-cdr/cdemud-1.0.0"
DEPEND="${COMMON_DEPEND}
	app-text/gnome-doc-utils
	dev-util/pkgconfig
	dev-util/intltool"
RDEPEND="${COMMON_DEPEND}
	libnotify? ( dev-python/notify-python )"

DOCS="AUTHORS ChangeLog README"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	# disable compilation of python modules
	echo '#!/bin/sh' > py-compile || die
	python_convert_shebangs 2 src/gcdemu
}

pkg_postinst() {
	python_mod_optimize ${PN}
	python_need_rebuild
}

pkg_postrm() {
	python_mod_cleanup ${PN}
}
