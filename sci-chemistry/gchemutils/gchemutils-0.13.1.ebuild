# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/gchemutils/gchemutils-0.13.1.ebuild,v 1.3 2011/04/24 17:20:15 eva Exp $

EAPI=3

inherit gnome2 multilib versionator

MPV=$(get_version_component_range 1-2)
MY_PN=gnome-chemistry-utils
MY_P=${MY_PN}-${PV}

DESCRIPTION="C++ classes and Gtk+-2 widgets related to chemistry"
HOMEPAGE="http://www.nongnu.org/gchemutils/"
SRC_URI="http://download.savannah.gnu.org/releases/${PN}/${MPV}/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="nls nsplugin"

CDEPEND="
	gnome-base/libglade:2.0
	x11-libs/goffice:0.8
	x11-libs/gtkglext
	sci-chemistry/chemical-mime-data
	sci-chemistry/bodr
	sci-chemistry/openbabel
	nsplugin? ( || (
		net-libs/xulrunner
		www-client/firefox
	) )"
RDEPEND="${CDEPEND}
	gnome-extra/yelp" #271998
DEPEND="${CDEPEND}
	app-text/gnome-doc-utils
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )"

S=${WORKDIR}/${MY_P}

pkg_setup() {
	G2CONF="${G2CONF}
		--disable-schemas-install
		--disable-scrollkeeper
		--disable-dependency-tracking
		--disable-update-databases
		$(use_enable nsplugin mozilla-plugin)
		$(use_enable nls)"

	if use nsplugin; then
		G2CONF="${G2CONF} --with-mozilla-libdir=/usr/$(get_libdir)/nsbrowser/"
	fi

	DOCS="AUTHORS ChangeLog README TODO NEWS"
}

src_test() {
	# There are no tests, and make check needlessly rebuilds docs needing extra
	# app-text/docbook-xml-dtd-{4.1.2,4.5} wtr bug 342743
	true
}

src_install() {
	gnome2_src_install
	find "${D}" -name "*.la" -delete
}

pkg_postinst() {
	gnome2_pkg_postinst
	elog "You can safely ignore any 'Unknown media type in type blah' warnings above."
	elog "For more info see http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=420795 "
}
