# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/dbus-python/dbus-python-0.71.ebuild,v 1.12 2007/04/04 14:06:21 kloeri Exp $

inherit distutils

DESCRIPTION="Python bindings for the D-Bus messagebus"
HOMEPAGE="http://dbus.freedesktop.org/"
SRC_URI="http://dbus.freedesktop.org/releases/${P}.tar.gz"

LICENSE="|| ( GPL-2 AFL-2.1 )"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 s390 sh sparc x86 ~x86-fbsd"

RDEPEND=">=dev-lang/python-2.4
	>=dev-python/pyrex-0.9.3-r2
	>=dev-libs/dbus-glib-0.71
	>=sys-apps/dbus-0.91"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

pkg_postrm() {
	python_mod_cleanup "${ROOT}"/usr/lib/python*/site-packages/dbus
}

pkg_postinst() {
	python_mod_optimize "${ROOT}"/usr/lib/python*/site-packages/dbus
}
