# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/libgdamm/libgdamm-4.1.1.ebuild,v 1.3 2011/03/31 13:51:29 nirbheek Exp $

EAPI="3"
GCONF_DEBUG="no"

inherit autotools gnome2

DESCRIPTION="C++ bindings for libgda"
HOMEPAGE="http://www.gtkmm.org"

LICENSE="LGPL-2.1"
SLOT="4"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="doc"

RDEPEND=">=dev-cpp/glibmm-2.12.8:2
	>=gnome-extra/libgda-4.1.7:4"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	doc? (
		app-doc/doxygen
		>=dev-cpp/mm-common-0.9.4 )"

pkg_setup() {
	DOCS="AUTHORS ChangeLog NEWS README TODO"
	G2CONF="${G2CONF} $(use_enable doc documentation)"
}

src_prepare() {
	# doc-install.pl was removed from glibmm, and is provided by mm-common now
	# This should not be needed if the tarball is generated with mm-common-0.9.3
	if use doc && has_version '>=dev-cpp/glibmm-2.27.97'; then
		mm-common-prepare --copy --force
		eautoreconf
	fi
	gnome2_src_prepare
}

src_install() {
	gnome2_src_install
	find "${ED}" -name "*.la" -delete || die "remove of la files failed"
}
