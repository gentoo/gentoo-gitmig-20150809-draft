# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/networkmanager-openconnect/networkmanager-openconnect-0.9.2.0-r1.ebuild,v 1.2 2012/05/05 03:20:42 jdhore Exp $

EAPI="4"
GNOME_ORG_MODULE="NetworkManager-${PN##*-}"

inherit eutils gnome.org user

DESCRIPTION="NetworkManager OpenConnect plugin"
HOMEPAGE="http://www.gnome.org/projects/NetworkManager/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gnome"

RDEPEND="
	>=net-misc/networkmanager-${PV}
	>=dev-libs/dbus-glib-0.74
	dev-libs/libxml2:2
	net-misc/openconnect
	gnome? (
		>=x11-libs/gtk+-2.91.4:3
		gnome-base/gconf:2
		gnome-base/gnome-keyring
	)"

DEPEND="${RDEPEND}
	sys-devel/gettext
	dev-util/intltool
	virtual/pkgconfig"

src_prepare() {
	# Upstream patch for glib-2.31 compatibility
	epatch "${FILESDIR}/${P}-glib-2.31.patch"
}

src_configure() {
	ECONF="--disable-more-warnings
		--disable-static
		--with-gtkver=3
		$(use_with gnome)
		$(use_with gnome authdlg)"

	econf ${ECONF}
}

src_install() {
	default
	# Remove useless .la files
	find "${D}" -name '*.la' -exec rm -f {} +
}

pkg_postinst() {
	enewgroup nm-openconnect
	enewuser nm-openconnect -1 -1 -1 nm-openconnect
}
