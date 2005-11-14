# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/bakery/bakery-2.3.15.ebuild,v 1.3 2005/11/14 14:26:53 metalgod Exp $

inherit gnome2

DESCRIPTION="Bakery is a C++ Framework for creating GNOME applications using
gtkmm."
HOMEPAGE="http://bakery.sourceforge.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ~x86"
IUSE="doc"

RDEPEND=">=dev-cpp/gtkmm-2.2
	>=dev-cpp/libxmlpp-1.0"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12"

DOCS="AUTHORS COPYING ChangeLog INSTALL NEWS README"

src_unpack() {
	unpack ${A}
	cd ${S}

	# don't waste time building the examples
	sed -i 's/^\(SUBDIRS =.*\)examples\(.*\)$/\1\2/' Makefile.in || \
			die "sed Makefile.in failed"
}

src_install() {
	gnome2_src_install
	use doc && dohtml docs/*.html docs/reference/*.html
}
