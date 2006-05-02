# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/bakery/bakery-2.3.18.ebuild,v 1.1 2006/05/02 03:38:05 compnerd Exp $

inherit gnome2

DESCRIPTION="Bakery is a C++ Framework for creating GNOME applications using gtkmm."
HOMEPAGE="http://bakery.sourceforge.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc examples"

RDEPEND=">=dev-cpp/gtkmm-2.8
		 >=dev-cpp/gconfmm-2.6
		 >=dev-cpp/libglademm-2.4
		 >=dev-cpp/libxmlpp-2.8
		 >=dev-cpp/gnome-vfsmm-2.6"
DEPEND="${RDEPEND}
		>=dev-util/intltool-0.25
		>=dev-util/pkgconfig-0.12"

DOCS="AUTHORS COPYING ChangeLog INSTALL NEWS README"

src_unpack() {
	unpack ${A}
	cd ${S}

	if ! use examples ; then
		sed -i 's/^\(SUBDIRS =.*\)examples\(.*\)$/\1\2/' Makefile.in || \
			die "sed Makefile.in failed"
	fi
}

src_install() {
	gnome2_src_install
	use doc && dohtml docs/*.html docs/reference/*.html
}
