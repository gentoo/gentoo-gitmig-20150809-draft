# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/gtksourceviewmm/gtksourceviewmm-2.2.0.ebuild,v 1.7 2010/07/20 16:35:05 jer Exp $

inherit gnome2

DESCRIPTION="C++ bindings for gtksourceview"
HOMEPAGE="http://home.gna.org/gtksourceviewmm/"

KEYWORDS="amd64 ppc x86"
IUSE="doc"
SLOT="2.0"
LICENSE="LGPL-2"

RDEPEND=">=dev-cpp/gtkmm-2.4
	>=x11-libs/gtksourceview-2.1.0
	!>=dev-cpp/libgtksourceviewmm-1"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	doc? ( app-doc/doxygen )"

DOCS="AUTHORS ChangeLog* NEWS README"

G2CONF="${G2CONF} $(use_enable doc docs)"

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
