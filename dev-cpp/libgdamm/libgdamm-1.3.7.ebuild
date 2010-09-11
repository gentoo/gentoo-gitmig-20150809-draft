# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/libgdamm/libgdamm-1.3.7.ebuild,v 1.9 2010/09/11 18:17:41 josejx Exp $

inherit gnome2

DESCRIPTION="C++ bindings for libgda"
HOMEPAGE="http://www.gtkmm.org"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ppc ~sparc x86"
IUSE="doc"

RDEPEND=">=dev-cpp/glibmm-2.4
	=gnome-extra/libgda-1*"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
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
