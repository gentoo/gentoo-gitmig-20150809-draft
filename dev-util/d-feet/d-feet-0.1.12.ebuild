# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/d-feet/d-feet-0.1.12.ebuild,v 1.1 2010/10/06 19:54:31 eva Exp $

GCONF_DEBUG="no"

inherit gnome2 distutils

DESCRIPTION="D-Feet is a powerful D-Bus debugger"
HOMEPAGE="http://live.gnome.org/d-feet/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gnome"

RDEPEND=">=sys-apps/dbus-1.0
	>=dev-python/dbus-python-0.82.3
	dev-python/pygtk
	>=dev-lang/python-2.5
	gnome? ( dev-python/libwnck-python )"

pkg_setup() {
	PYTHON_MODNAME="dfeet"
}

pkg_postinst()
{
	distutils_pkg_postinst
	gnome2_icon_cache_update
}
