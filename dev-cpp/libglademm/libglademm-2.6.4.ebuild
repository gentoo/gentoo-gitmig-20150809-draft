# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/libglademm/libglademm-2.6.4.ebuild,v 1.13 2011/03/29 06:10:54 nirbheek Exp $

EAPI="1"

inherit gnome2

DESCRIPTION="C++ bindings for libglade"
HOMEPAGE="http://www.gtkmm.org"

LICENSE="LGPL-2.1"
SLOT="2.4"
KEYWORDS="arm ppc64 sh"
IUSE="doc examples"

RDEPEND=">=gnome-base/libglade-2.6.1:2.0
	>=dev-cpp/gtkmm-2.6:2.4"

DEPEND=">=dev-util/pkgconfig-0.12.0
	${RDEPEND}"

DOCS="AUTHORS ChangeLog NEWS README TODO"

src_unpack() {
	gnome2_src_unpack

	# we will control install manually in install
	sed -i 's/^\(SUBDIRS =.*\)docs\(.*\)$/\1\2/' Makefile.in || \
		die "sed Makefile.in failed"

	if ! use examples; then
		# don't waste time building the examples
		sed -i 's/^\(SUBDIRS =.*\)examples\(.*\)$/\1\2/' Makefile.in || \
			die "sed Makefile.in failed"
	fi
}

src_compile() {
	gnome2_src_compile

	if use doc; then
		cd "${S}/docs/reference"
		make all
	fi
}

src_install() {
	gnome2_src_install

	if use doc ; then
		dohtml -r docs/reference/html/*
	fi

	if use examples; then
		cp -R examples "${D}"/usr/share/doc/${PF}
	fi
}
