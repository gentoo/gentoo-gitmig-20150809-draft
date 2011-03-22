# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/gtksourceview-python/gtksourceview-python-2.32.0.ebuild,v 1.8 2011/03/22 18:59:49 ranger Exp $

EAPI="3"
GCONF_DEBUG="no"
G_PY_PN="gnome-python-desktop"
SUPPORT_PYTHON_ABIS="1"
PYTHON_DEPEND="2"
RESTRICT_PYTHON_ABIS="3.*"

inherit gnome-python-common

DESCRIPTION="Python bindings for the gtksourceview (version 1.8) library"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm ia64 ppc ppc64 sh sparc x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~ia64-linux ~x86-linux"
IUSE="doc examples"

RDEPEND="x11-libs/gtksourceview:1.0
	>=dev-python/libgnomeprint-python-2.25.90
	!<dev-python/gnome-python-desktop-2.22.0-r10"
DEPEND="${RDEPEND}"

EXAMPLES="examples/gtksourceview/*"

pkg_postinst() {
	elog
	elog "This package provides python bindings for x11-libs/gtksourceview-1.8."
	elog "If you want to 2.* python bindings, use dev-python/pygtksourceview-2"
}
