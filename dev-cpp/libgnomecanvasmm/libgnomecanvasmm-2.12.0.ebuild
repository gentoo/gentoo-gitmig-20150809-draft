# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/libgnomecanvasmm/libgnomecanvasmm-2.12.0.ebuild,v 1.12 2006/07/15 03:25:34 vapier Exp $

inherit gnome2

DESCRIPTION="C++ bindings for libgnomecanvas"
HOMEPAGE="http://gtkmm.sourceforge.net/"

LICENSE="LGPL-2.1"
SLOT="2.6"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sh sparc x86"
IUSE="doc"

RDEPEND=">=gnome-base/libgnomecanvas-2.6
	>=dev-cpp/gtkmm-2.4"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0
	doc? ( app-doc/doxygen )"

DOCS="AUTHORS ChangeLog NEWS README TODO INSTALL"

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
