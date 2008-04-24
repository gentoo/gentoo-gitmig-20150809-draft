# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/linkage/linkage-0.1.4.ebuild,v 1.6 2008/04/24 14:56:56 drac Exp $

SCROLLKEEPER_UPDATE=no
GCONF_DEBUG=no

inherit gnome2

DESCRIPTION="BitTorrent client written in C++ using gtkmm and libtorrent."
HOMEPAGE="http://code.google.com/p/linkage"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.gz
	http://code.google.com/p/${PN}/source/browse/tags/${P}/m4/sizeof.m4"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="curl gnome upnp xfce"

RDEPEND="~net-libs/rb_libtorrent-0.12
	>=dev-cpp/gtkmm-2.10
	>=dev-cpp/gconfmm-2.6
	>=dev-cpp/libglademm-2.6
	>=x11-libs/libnotify-0.4.4
	>=dev-libs/dbus-glib-0.73
	curl? ( >=net-misc/curl-7.14 )
	gnome? ( >=dev-cpp/libgnomemm-2.16
		>=dev-cpp/gnome-vfsmm-2.16
		>=dev-cpp/libgnomeuimm-2.16 )
	xfce? ( >=xfce-extra/exo-0.3 )
	upnp? ( >=net-libs/gupnp-0.4 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-devel/gettext"

DOCS="README TODO"

pkg_setup() {
	G2CONF="${G2CONF} $(use_with curl) $(use_with gnome)
		$(use_with upnp gupnp) $(use_with xfce exo)"
}

src_unpack() {
	# Bug 208548, sizeof.m4 isn't included in default tarball.
	unpack ${P}.tar.gz
	cd "${S}"
	mkdir m4
	cp ${DISTDIR}/sizeof.m4 m4
}
