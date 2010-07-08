# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gget/gget-0.0.4.ebuild,v 1.2 2010/07/08 12:48:53 arfrever Exp $

EAPI="1"
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
	>=dev-python/gnome-python-2.16
	>=dev-python/gnome-python-extras-2.14.2
	>=dev-python/notify-python-0.1.1
	>=dev-python/pygtk-2.10
	>=dev-python/pygobject-2.12
	gnome-base/gconf:2
	>=x11-libs/gtk+-2.10
	epiphany? ( www-client/epiphany-extensions )"
DEPEND="${RDEPEND}
	dev-util/intltool
	dev-util/pkgconfig"

pkg_setup() {
	G2CONF="${G2CONF}
		$(use_enable epiphany epiphany-extension)
		$(use_enable epiphany epiphany-extension-install)"
}
src_unpack() {
	gnome2_src_unpack
	# Being executable with python > 2.5
	sed -e 's:/usr/bin/env python2.5:/usr/bin/python:g' -i bin/gget.in \
		|| die "sed 1 failed"
	# Make configure script compatible with epy 2.26 and 2.28
	# and cleanup this var
	sed -e 's:\(VALID_EPIPHANY_VERSIONS=\)\".*\":\1"2.28 2.26 2.24":g' \
		-i configure || die "sed 2 failed"
}
pkg_postinst() {
	gnome2_pkg_postinst
	python_mod_optimize "$(python_get_sitedir)"/gget/*.py
}
