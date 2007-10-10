# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pygtksourceview/pygtksourceview-2.0.0.ebuild,v 1.1 2007/10/10 21:22:53 remi Exp $

NEED_PYTHON=2.3.5

inherit gnome2 python flag-o-matic

DESCRIPTION="GTK+2 bindings for Python"
HOMEPAGE="http://www.pygtk.org/"

SRC_URI="${SRC_URI}"

LICENSE="LGPL-2.1"
SLOT="2"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd"

RDEPEND=">=dev-python/pygobject-2.11.3
	>=dev-python/pygtk-2.8
	>=x11-libs/gtksourceview-2"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9"

pkg_postinst() {
	python_version
	python_mod_optimize /usr/$(get_libdir)/python${PYVER}/site-packages/
}

pkg_postrm() {
	python_version
	python_mod_optimize /usr/$(get_libdir)/python${PYVER}/site-packages/
}
