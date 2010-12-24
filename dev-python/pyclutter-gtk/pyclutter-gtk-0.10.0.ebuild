# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyclutter-gtk/pyclutter-gtk-0.10.0.ebuild,v 1.2 2010/12/24 13:35:26 nirbheek Exp $

EAPI="2"

inherit python clutter

DESCRIPTION="Python bindings for Clutter-GTK"

KEYWORDS="~amd64 ~x86"
IUSE="doc examples"

SLOT="0.10"
RDEPEND=">=dev-lang/python-2.5
	>=dev-python/pygtk-2.8.0
	>=dev-python/pyclutter-1.0.0:1.0
	>=media-libs/clutter-1.0.0:1.0
	>=media-libs/clutter-gtk-0.10.2:${SLOT}"
DEPEND="${RDEPEND}
	doc? ( dev-libs/libxslt )"
EXAMPLES="examples/*.py"
DOCS="NEWS AUTHORS README ChangeLog"

src_configure() {
	# XXX: doc use-flag doesn't do anything yet
	local myconf="
		$(use_enable doc docs)"

	econf ${myconf}

	# Don't pre-compile .py
	ln -sf $(type -P true) py-compile
}

pkg_postinst() {
	python_mod_optimize $(python_get_sitedir)/cluttergtk/*
	python_need_rebuild
}

pkg_postrm() {
	python_mod_cleanup /usr/lib*/python*/site-packages/cluttergtk/*
}
