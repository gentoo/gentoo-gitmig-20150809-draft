# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyclutter-gtk/pyclutter-gtk-0.10.0-r1.ebuild,v 1.4 2012/01/14 16:41:21 maekke Exp $

EAPI="3"
PYTHON_DEPEND="2:2.6"

inherit python clutter

DESCRIPTION="Python bindings for Clutter-GTK"

KEYWORDS="amd64 x86"
IUSE="doc examples"

SLOT="0.10"
RDEPEND="
	>=dev-python/pygtk-2.8.0
	>=dev-python/pyclutter-1.0.0:1.0
	>=media-libs/clutter-1.0.0:1.0
	>=media-libs/clutter-gtk-0.10.2:${SLOT}"
DEPEND="${RDEPEND}
	doc? ( dev-libs/libxslt )"
EXAMPLES="examples/*.py"
DOCS="NEWS AUTHORS README ChangeLog"

pkg_setup() {
	python_set_active_version 2
}

src_prepare() {
	# Don't pre-compile .py
	ln -sf $(type -P true) py-compile
	python_convert_shebangs --recursive 2 examples
	default_src_prepare
}

src_configure() {
	# XXX: doc use-flag doesn't do anything yet
	local myconf="
		$(use_enable doc docs)"

	econf ${myconf}
}

pkg_postinst() {
	python_mod_optimize cluttergtk
	python_need_rebuild
}

pkg_postrm() {
	python_mod_cleanup cluttergtk
}
