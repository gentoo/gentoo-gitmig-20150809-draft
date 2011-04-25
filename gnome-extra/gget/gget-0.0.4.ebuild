# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gget/gget-0.0.4.ebuild,v 1.4 2011/04/25 21:08:46 arfrever Exp $

EAPI="3"
GCONF_DEBUG="no"
PYTHON_DEPEND="2:2.5"

inherit gnome2 python

DESCRIPTION="A DownLoad Manager for GNOME"
HOMEPAGE="http://live.gnome.org/GGet"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="epiphany"

RDEPEND=">=dev-python/dbus-python-0.82
	>=dev-python/gconf-python-2.16
	>=dev-python/libgnome-python-2.16
	>=dev-python/gnome-desktop-python-2.16
	>=dev-python/gnome-vfs-python-2.16
	>=dev-python/egg-python-2.14.2
	>=dev-python/notify-python-0.1.1
	>=dev-python/pygtk-2.10:2
	>=dev-python/pygobject-2.12:2
	gnome-base/gconf:2
	>=x11-libs/gtk+-2.10:2
	epiphany? ( www-client/epiphany-extensions )"
DEPEND="${RDEPEND}
	dev-util/intltool
	dev-util/pkgconfig"

pkg_setup() {
	G2CONF="${G2CONF}
		$(use_enable epiphany epiphany-extension)
		$(use_enable epiphany epiphany-extension-install)"
	python_set_active_version 2
}
src_prepare() {
	gnome2_src_prepare

	# disable pyc compiling
	rm py-compile
	ln -s $(type -P true) py-compile

	# Make configure script compatible with epy 2.26 and 2.28
	# and cleanup this var
	sed -e 's:\(VALID_EPIPHANY_VERSIONS=\)\".*\":\1"2.28 2.26 2.24":g' \
		-i configure || die "sed 1 failed"
}

src_install() {
	gnome2_src_install
	python_clean_installation_image
	python_convert_shebangs 2 "${D}"/usr/bin/gget
}

pkg_postinst() {
	gnome2_pkg_postinst
	python_mod_optimize gget
}

pkg_postrm() {
	gnome2_pkg_postrm
	python_mod_cleanup gget
}
