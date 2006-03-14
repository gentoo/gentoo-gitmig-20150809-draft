# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/libgnomecanvasmm/libgnomecanvasmm-2.12.0.ebuild,v 1.7 2006/03/14 23:15:19 gustavoz Exp $

inherit gnome2

DESCRIPTION="C++ bindings for libgnomecanvas"
HOMEPAGE="http://gtkmm.sourceforge.net/"

LICENSE="LGPL-2.1"
SLOT="2.6"
KEYWORDS="amd64 hppa ppc ppc64 sparc x86"
IUSE="doc"

RDEPEND=">=gnome-base/libgnomecanvas-2.6
	>=dev-cpp/gtkmm-2.4"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0
	doc? ( app-doc/doxygen )"

DOCS="AUTHORS COPYING ChangeLog NEWS README TODO INSTALL"

src_compile() {
	if useq amd64; then
		libtoolize --copy --force
		aclocal -I scripts
		autoconf
		automake -c -f
	fi

	gnome2_src_compile

	if use doc ; then
		einfo "Building API documentation"
		cd docs/reference
		emake || die "failed to build API docs"
	fi
}

src_install() {
	gnome2_src_install

	if use doc ; then
		cd docs/reference
		dohtml -r html/*
	fi
}
