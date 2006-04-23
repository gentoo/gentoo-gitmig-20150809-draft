# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/pessulus/pessulus-0.9.1.ebuild,v 1.2 2006/04/23 17:31:06 allanonjl Exp $

inherit gnome2 python

DESCRIPTION="lockdown editor for GNOME"
HOMEPAGE="http://live.gnome.org/Pessulus"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc"

RDEPEND=">=dev-python/pygtk-2.6.0
	>=dev-python/gnome-python-2.6.0
	>=gnome-base/gconf-2"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9
	dev-util/intltool
	doc? ( >=dev-util/gtk-doc-1 )"

pkg_postinst() {
	python_version
	python_mod_optimize ${ROOT}/usr/$(get_libdir)/python${PYVER}/site-packages/Pessulus
}

pkg_postrm() {
	python_version
	python_mod_cleanup
}
