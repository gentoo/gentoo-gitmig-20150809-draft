# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/gtkglextmm/gtkglextmm-1.2.0.ebuild,v 1.1 2006/06/12 13:19:34 allanonjl Exp $

inherit gnome2

DESCRIPTION="C++ bindings for gtkglext"
HOMEPAGE="http://gtkglext.sourceforge.net/"
SRC_URI="mirror://sourceforge/gtkglext/${P}.tar.bz2"

KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc"
SLOT="1.0"
LICENSE="GPL-2 LGPL-2.1"

RDEPEND=">=x11-libs/gtkglext-1
	>=dev-libs/libsigc++-2.0
	>=dev-cpp/glibmm-2.4
	>=dev-cpp/gtkmm-2.4
	virtual/opengl
	virtual/glu"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

DOCS="AUTHORS ChangeLog* NEWS README TODO"

src_unpack() {
	gnome2_src_unpack

	# Remove docs from SUBDIRS so that docs are not installed, as
	# we handle it in src_install.
	sed -i -e 's|^\(SUBDIRS =.*\)docs\(.*\)|\1\2|' Makefile.in || \
		die "sed Makefile.in failed"
}

src_compile() {
	if [ "${ARCH}" = "amd64" ]; then
		aclocal -I m4macros
		automake -c -f
		autoconf
	fi
	gnome2_src_compile
}

src_install() {
	gnome2_src_install
	use doc && dohtml -r docs/reference/html/*
}
