# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyclutter-gst/pyclutter-gst-1.0.0.ebuild,v 1.1 2010/02/26 22:56:31 nirbheek Exp $

EAPI="2"

inherit python clutter

DESCRIPTION="Python bindings for Clutter"

KEYWORDS="~amd64 ~x86"
IUSE="examples"

SLOT="1.0"
RDEPEND=">=dev-lang/python-2.5
	>=dev-python/pygobject-2.12.1
	>=dev-python/pyclutter-1.0.0:${SLOT}
	>=media-libs/clutter-1.0.0:${SLOT}
	>=media-libs/clutter-gst-1.0.0:${SLOT}

	dev-python/gst-python"
DEPEND="${RDEPEND}"
EXAMPLES="examples/*.py"
DOCS="NEWS AUTHORS README ChangeLog"

src_prepare(){
	# Don't pre-compile .py
	ln -sf $(type -P true) py-compile
}

pkg_postinst() {
	python_mod_optimize $(python_get_sitedir)/cluttergst/*
	python_need_rebuild
}

pkg_postrm() {
	python_mod_cleanup /usr/lib*/python*/site-packages/cluttergst/*
}
