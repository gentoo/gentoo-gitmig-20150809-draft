# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/glibmm/glibmm-2.4.7-r1.ebuild,v 1.3 2005/05/08 09:15:42 kloeri Exp $

inherit gnome2

DESCRIPTION="C++ interface for glib2"
HOMEPAGE="http://gtkmm.sourceforge.net/"

LICENSE="LGPL-2.1"
SLOT="2"
KEYWORDS="x86 ~ppc amd64 ~sparc ~ppc64 ~alpha ~hppa ~ia64"
IUSE="doc"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	doc? ( app-doc/doxygen )"

RDEPEND=">=dev-libs/libsigc++-2.0
		>=dev-libs/glib-2.4"

DOCS="AUTHORS CHANGES ChangeLog NEWS README"

src_unpack() {
	unpack ${A}
	cd ${S}
	# don't waste time building the examples
	sed -i 's/^\(SUBDIRS =.*\)examples\(.*\)$/\1\2/' Makefile.in || \
		die "sed Makefile.in failed"
}

src_install() {
	gnome2_src_install
	rm -fr ${D}/usr/share/doc/${P%.*}
	if use doc ; then
		# API Reference
		dohtml -r docs/reference/html/* docs/images/*
		dosed -i 's?../../images/??g' /usr/share/doc/${PF}/html/*.html
		# examples
		cp -R examples ${D}/usr/share/doc/${PF}
	fi
}
