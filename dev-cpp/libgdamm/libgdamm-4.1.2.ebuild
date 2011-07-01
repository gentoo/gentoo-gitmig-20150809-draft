# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/libgdamm/libgdamm-4.1.2.ebuild,v 1.2 2011/07/01 10:36:14 hwoarang Exp $

EAPI="3"
GCONF_DEBUG="no"

inherit autotools gnome2

DESCRIPTION="C++ bindings for libgda"
HOMEPAGE="http://www.gtkmm.org"

LICENSE="LGPL-2.1"
SLOT="4"
KEYWORDS="amd64 ~ppc ~sparc ~x86"
IUSE="berkdb doc"

RDEPEND=">=dev-cpp/glibmm-2.27.93:2[doc?]
	>=gnome-extra/libgda-4.1.7:4[berkdb=]"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=dev-cpp/mm-common-0.7.2
	doc? ( app-doc/doxygen )"

pkg_setup() {
	DOCS="AUTHORS ChangeLog NEWS README TODO"
	G2CONF="${G2CONF} $(use_enable doc documentation)"
}

src_prepare() {
	if use doc; then
		mm-common-prepare --copy --force
		eautoreconf
	fi

	gnome2_src_prepare
}

src_install() {
	gnome2_src_install
	#use doc && dohtml -r docs/reference/html/*
	find "${ED}" -name "*.la" -delete || die "remove of la files failed"
}
