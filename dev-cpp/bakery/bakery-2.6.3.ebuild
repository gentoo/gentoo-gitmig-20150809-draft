# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/bakery/bakery-2.6.3.ebuild,v 1.2 2011/03/29 06:08:38 nirbheek Exp $

EAPI="2"

inherit gnome2

DESCRIPTION="Bakery is a C++ Framework for creating GNOME applications using gtkmm."
HOMEPAGE="http://bakery.sourceforge.net/"
LICENSE="GPL-2"
SLOT="2.6"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc examples"

RDEPEND=">=dev-cpp/gtkmm-2.10:2.4
	>=dev-cpp/gconfmm-2.6
	>=dev-cpp/libglademm-2.4:2.4
	>=dev-cpp/libxmlpp-2.6:2.6
	>=dev-cpp/glibmm-2.16:2"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.25
	>=dev-util/pkgconfig-0.12"

DOCS="AUTHORS ChangeLog NEWS README"

src_prepare() {
	gnome2_src_prepare

	# should be configured via configure switch
	if ! use examples ; then
		sed 's/^\(SUBDIRS =.*\)examples\(.*\)$/\1\2/' \
			-i Makefile.am Makefile.in || \
			die "sed Makefile.am failed"
	fi
}

src_configure() {
	G2CONF="${G2CONF} --disable-option-checking --disable-maemo"
	gnome2_src_configure
}

src_install() {
	gnome2_src_install
	use doc && dohtml docs/*.html docs/reference/*.html
}
