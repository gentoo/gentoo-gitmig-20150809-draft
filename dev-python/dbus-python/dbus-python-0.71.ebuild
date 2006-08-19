# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/dbus-python/dbus-python-0.71.ebuild,v 1.1 2006/08/19 00:18:56 steev Exp $

inherit distutils

DESCRIPTION="Python bindings for the D-Bus messagebus."
HOMEPAGE="http://dbus.freedesktop.org/"
SRC_URI="http://dbus.freedesktop.org/releases/${P}.tar.gz"

SLOT="0"
LICENSE="|| ( GPL-2 AFL-2.1 )"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"

RDEPEND=">=dev-lang/python-2.4
	>=dev-python/pyrex-0.9.3-r2
	>=sys-apps/dbus-core-0.91"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

pkg_postrm() {
	python_mod_cleanup "${ROOT}"/usr/lib/python*/site-packages/dbus
}

pkg_postinst() {
	python_mod_optimize "${ROOT}"/usr/lib/python*/site-packages/dbus
}
