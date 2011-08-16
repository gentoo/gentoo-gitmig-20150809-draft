# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/networkmanager-openvpn/networkmanager-openvpn-0.9_rc3.ebuild,v 1.2 2011/08/16 10:07:06 nirbheek Exp $

EAPI="4"
GNOME_ORG_MODULE="NetworkManager-${PN##*-}"
GNOME_ORG_PVP="0.8"
REAL_PV="0.8.9997"

inherit gnome.org

DESCRIPTION="NetworkManager OpenVPN plugin"
HOMEPAGE="http://www.gnome.org/projects/NetworkManager/"
# Replace our fake _rc version with the actual version
SRC_URI="${SRC_URI//${PV}/${REAL_PV}}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gnome test"

RDEPEND="
	>=dev-libs/dbus-glib-0.74
	>=net-misc/networkmanager-${PV}
	>=net-misc/openvpn-2.1_rc9
	gnome? (
		>=x11-libs/gtk+-2.91.4:3
		gnome-base/gnome-keyring
	)"

DEPEND="${RDEPEND}
	sys-devel/gettext
	>=dev-util/intltool-0.35
	dev-util/pkgconfig"

# Replace our fake _rc version with the actual version
S="${WORKDIR}/${GNOME_ORG_MODULE}-${REAL_PV}"

# FAIL: (tls-import-data) unexpected 'ca' secret value
#RESTRICT="test"

src_configure() {
	ECONF="--disable-more-warnings
		--disable-static
		--with-dist-version=Gentoo
		--with-gtkver=3.0
		$(use_with gnome)
		$(use_with test tests)"

	econf ${ECONF}
}

src_install() {
	default
	# Remove useless .la files
	find "${D}" -name '*.la' -exec rm -f {} +
}
