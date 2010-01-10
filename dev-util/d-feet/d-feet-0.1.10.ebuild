# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/d-feet/d-feet-0.1.10.ebuild,v 1.1 2010/01/10 18:26:12 patrick Exp $

inherit gnome2 distutils

DESCRIPTION="D-Feet is a powerful D-Bus debugger"
HOMEPAGE="https://fedorahosted.org/d-feet/"
SRC_URI="http://johnp.fedorapeople.org/downloads/d-feet/${P}.tar.gz"

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
