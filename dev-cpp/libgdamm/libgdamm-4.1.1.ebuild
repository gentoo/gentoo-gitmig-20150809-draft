# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/libgdamm/libgdamm-4.1.1.ebuild,v 1.2 2011/02/17 10:15:01 pacho Exp $

EAPI="3"
GCONF_DEBUG="no"

inherit gnome2

DESCRIPTION="C++ bindings for libgda"
HOMEPAGE="http://www.gtkmm.org"

LICENSE="LGPL-2.1"
SLOT="4"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="doc"

RDEPEND=">=dev-cpp/glibmm-2.12.8:2[doc?]
	>=gnome-extra/libgda-4.1.7:4"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	doc? ( app-doc/doxygen )"

pkg_setup() {
	DOCS="AUTHORS ChangeLog NEWS README TODO"
	G2CONF="${G2CONF} $(use_enable doc documentation)"
}

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
	find "${ED}" -name "*.la" -delete || die "remove of la files failed"
}
