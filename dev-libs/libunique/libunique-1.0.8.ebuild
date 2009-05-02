# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libunique/libunique-1.0.8.ebuild,v 1.1 2009/05/02 22:29:10 eva Exp $

EAPI="2"

inherit autotools eutils gnome2 virtualx

DESCRIPTION="a library for writing single instance application"
HOMEPAGE="http://live.gnome.org/LibUnique"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="dbus debug doc"

RDEPEND=">=dev-libs/glib-2.12.0
	>=x11-libs/gtk+-2.11.0
	x11-libs/libX11
	dbus? ( >=dev-libs/dbus-glib-0.70 )"
DEPEND="${RDEPEND}
	sys-devel/gettext
	>=dev-util/pkgconfig-0.17
	doc? ( >=dev-util/gtk-doc-1.6 )"

DOCS="AUTHORS NEWS ChangeLog README TODO"

src_prepare() {
	gnome2_src_prepare

	# Make dbus support configurable, bug #265828
	epatch "${FILESDIR}/${P}-automagic-dbus.patch"
	eautoreconf
}

src_test() {
	cd "${S}/tests"

	cp "${FILESDIR}/run-tests" .
	Xemake -f run-tests || die "Tests failed"
}

pkg_setup() {
	G2CONF="${G2CONF}
		--disable-static
		$(use_enable dbus)
		$(use_enable debug)"
}
