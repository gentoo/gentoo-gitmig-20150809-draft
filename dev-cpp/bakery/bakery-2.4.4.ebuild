# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/bakery/bakery-2.4.4.ebuild,v 1.3 2011/03/29 06:09:56 nirbheek Exp $

EAPI="1"

inherit autotools gnome2

DESCRIPTION="Bakery is a C++ Framework for creating GNOME applications using gtkmm."
HOMEPAGE="http://bakery.sourceforge.net/"

LICENSE="GPL-2"
SLOT="2.4"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc examples"

RDEPEND=">=dev-cpp/gtkmm-2.10:2.4
		 >=dev-cpp/gconfmm-2.6
		 >=dev-cpp/libglademm-2.4:2.4
		 >=dev-cpp/libxmlpp-2.8:2.6
		 >=dev-cpp/gnome-vfsmm-2.6:1.1"
DEPEND="${RDEPEND}
		>=dev-util/intltool-0.25
		>=dev-util/pkgconfig-0.12"

DOCS="AUTHORS COPYING ChangeLog INSTALL NEWS README"

pkg_setup() {
	G2CONF="--disable-option-checking --disable-maemo"
}

src_unpack() {
	gnome2_src_unpack

	sed -i "/AM_INIT/ a \AM_MAINTAINER_MODE" configure.in || \
		die "sed maintainer-mode failed"

	# should be configured via configure switch
	if ! use examples ; then
		sed -i 's/^\(SUBDIRS =.*\)examples\(.*\)$/\1\2/' Makefile.am || \
			die "sed Makefile.am failed"
	fi

	eautoreconf
}

src_install() {
	gnome2_src_install
	use doc && dohtml docs/*.html docs/reference/*.html
}
