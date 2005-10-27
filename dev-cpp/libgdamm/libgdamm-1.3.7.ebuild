# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/libgdamm/libgdamm-1.3.7.ebuild,v 1.2 2005/10/27 02:45:31 weeve Exp $

inherit gnome2

DESCRIPTION="C++ bindings for libgda"
HOMEPAGE="http://gtkmm.sourceforge.net/"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~ppc ~sparc ~x86"
IUSE="doc"

RDEPEND=">=dev-cpp/glibmm-2.4
	>=gnome-extra/libgda-1.1.4"
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
