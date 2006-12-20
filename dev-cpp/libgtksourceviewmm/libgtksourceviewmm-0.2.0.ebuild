# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/libgtksourceviewmm/libgtksourceviewmm-0.2.0.ebuild,v 1.2 2006/12/20 04:10:02 dang Exp $

inherit gnome2

DESCRIPTION="C++ bindings for gtksourceview"
HOMEPAGE="http://home.gna.org/gtksourceviewmm/"

KEYWORDS="~amd64 ~x86"
IUSE="doc"
SLOT="0"
LICENSE="LGPL-2"

RDEPEND=">=dev-cpp/gtkmm-2.4
	>=x11-libs/gtksourceview-1.2.0"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	doc? ( app-doc/doxygen )"

DOCS="AUTHORS ChangeLog* NEWS README TODO"

src_unpack() {
	gnome2_src_unpack

	# Remove docs from SUBDIRS so that docs are not installed, as
	# we handle it in src_install.
	sed -i -e 's|^\(SUBDIRS =.*\)docs\(.*\)|\1\2|' Makefile.in || \
		die "sed Makefile.in failed"
}

src_install() {
	gnome2_src_install
	use doc && dohtml -r docs/reference/html/*
}
