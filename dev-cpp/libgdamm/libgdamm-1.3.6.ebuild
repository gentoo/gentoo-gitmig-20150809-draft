# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/libgdamm/libgdamm-1.3.6.ebuild,v 1.4 2007/06/24 09:10:54 eva Exp $

inherit gnome2

DESCRIPTION="C++ bindings for libgda"
HOMEPAGE="http://gtkmm.sourceforge.net/"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE="doc"

RDEPEND=">=dev-cpp/glibmm-2.4
	=gnome-extra/libgda-1*"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )"

DOCS="AUTHORS ChangeLog README TODO"

src_compile() {
	gnome2_src_compile

	if use doc ; then
		cd docs/reference
		emake || die "failed to build API docs"
	fi
}

src_install() {
	gnome2_src_install
	use doc && dohtml -r docs/reference/html/*
}
