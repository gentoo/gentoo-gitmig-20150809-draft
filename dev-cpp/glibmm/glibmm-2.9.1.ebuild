# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/glibmm/glibmm-2.9.1.ebuild,v 1.2 2006/12/04 16:26:09 vapier Exp $

inherit gnome2

DESCRIPTION="C++ interface for glib2"
HOMEPAGE="http://gtkmm.sourceforge.net/"

LICENSE="LGPL-2.1"
SLOT="2"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86"
IUSE="doc"

RDEPEND=">=dev-libs/libsigc++-2.0.11
	>=dev-libs/glib-2.9"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	doc? ( app-doc/doxygen )"

DOCS="AUTHORS CHANGES ChangeLog NEWS README"

src_unpack() {
	unpack ${A}
	cd ${S}

	# don't waste time building the examples
	sed -i 's/^\(SUBDIRS =.*\)examples docs\(.*\)$/\1\2/' Makefile.in || \
		die "sed Makefile.in failed"

	# fix image paths
	if use doc ; then
		sed -i 's|../../images/||g' docs/reference/html/*.html || \
			die "sed failed"
	fi
}

src_install() {
	gnome2_src_install
	rm -fr ${D}/usr/share/doc/glibmm-2.4
	if use doc ; then
		# API Reference
		dohtml -r docs/reference/html/* docs/images/*
		# examples
		find examples -type d -name '.deps' -exec rm -fr {} \; 2>/dev/null
		cp -R examples ${D}/usr/share/doc/${PF}
	fi
}
