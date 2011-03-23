# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/music-applet/music-applet-2.5.1.ebuild,v 1.6 2011/03/23 08:21:32 nirbheek Exp $

EAPI="3"
PYTHON_DEPEND="2"

inherit gnome2 python eutils

DESCRIPTION="GNOME applet to control various music players"
HOMEPAGE="http://www.kuliniewicz.org/music-applet"
SRC_URI="http://www.kuliniewicz.org/${PN}/downloads/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="libnotify mpd"

# This ebuild is far from perfect, it does a lot of automagic detection

RDEPEND=">=x11-libs/gtk+-2.6:2
	>=x11-libs/pango-1.6
	>=gnome-base/libgnomeui-2
	|| ( gnome-base/gnome-panel[bonobo] <gnome-base/gnome-panel-2.32 )
	>=dev-python/gconf-python-2.14
	>=dev-python/gnome-keyring-python-2.14
	>=dev-python/gnome-applets-python-2.14
	>=dev-python/dbus-python-0.80
	>=dev-libs/dbus-glib-0.71
	>=dev-python/pygtk-2.6:2
	dev-python/pygobject:2
	libnotify? ( dev-python/notify-python )
	mpd? ( >=dev-python/python-mpd-0.2.1 )"
DEPEND="dev-util/pkgconfig
	dev-util/intltool"

pkg_setup() {
	python_set_active_version 2
}

src_prepare() {
	gnome2_src_prepare

	# disable pyc compiling
	mv py-compile py-compile.orig
	ln -s $(type -P true) py-compile

	python_convert_shebangs -r 2 .
}

pkg_postinst() {
	gnome2_pkg_postinst
	python_mod_optimize musicapplet
}

pkg_postrm() {
	gnome2_pkg_postrm
	python_mod_cleanup musicapplet
}
