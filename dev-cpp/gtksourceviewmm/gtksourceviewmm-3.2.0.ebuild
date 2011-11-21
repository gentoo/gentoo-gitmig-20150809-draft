# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/gtksourceviewmm/gtksourceviewmm-3.2.0.ebuild,v 1.1 2011/11/21 22:05:33 eva Exp $

EAPI="4"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"

inherit gnome2

DESCRIPTION="C++ bindings for gtksourceview"
HOMEPAGE="http://projects.gnome.org/gtksourceviewmm/"

KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc"
SLOT="3.0"
LICENSE="LGPL-2.1"

RDEPEND=">=dev-cpp/glibmm-2.28:2
	>=dev-cpp/gtkmm-3.2:3.0
	>=x11-libs/gtksourceview-3.2:3.0

	dev-cpp/atkmm
	dev-cpp/cairomm
	dev-cpp/pangomm:1.4"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	doc? ( app-doc/doxygen )"

pkg_setup() {
	DOCS="AUTHORS ChangeLog* NEWS README"
	G2CONF="${G2CONF} $(use_enable doc documentation)"
}
