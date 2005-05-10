# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/glibmm/glibmm-2.6.1.ebuild,v 1.5 2005/05/10 18:16:56 ka0ttic Exp $

inherit gnome2

DESCRIPTION="C++ interface for glib2"
HOMEPAGE="http://gtkmm.sourceforge.net/"

LICENSE="LGPL-2.1"
SLOT="2"
KEYWORDS="~x86 ~ppc ~amd64 ~sparc ~ppc64 ~alpha ~hppa"
IUSE="doc"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	doc? ( app-doc/doxygen )"

RDEPEND=">=dev-libs/libsigc++-2.0.11
		>=dev-libs/glib-2.4"

DOCS="AUTHORS CHANGES ChangeLog NEWS README"

src_unpack() {
	unpack ${A}
	cd ${S}
	# don't waste time building the examples
	sed -i 's/^\(SUBDIRS =.*\)examples\(.*\)$/\1\2/' Makefile.in || \
		die "sed Makefile.in failed"

	if use doc ; then
		sed -i 's|../../images/||g' docs/reference/html/*.html || \
			die "sed failed"
	fi
}

src_install() {
	gnome2_src_install
	rm -fr ${D}/usr/share/doc/${PN}*
	if use doc ; then
		# API Reference
		dohtml -r docs/reference/html/* docs/images/*
		# examples
		cp -R examples ${D}/usr/share/doc/${PF}
	fi
}
