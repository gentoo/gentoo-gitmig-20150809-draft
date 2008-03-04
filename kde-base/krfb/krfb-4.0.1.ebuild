# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/krfb/krfb-4.0.1.ebuild,v 1.2 2008/03/04 05:45:14 jer Exp $

EAPI="1"

KMNAME=kdenetwork
inherit kde4-meta

DESCRIPTION="VNC-compatible server to share KDE desktops"
KEYWORDS="~amd64 ~hppa ~x86"
IUSE="debug htmlhandbook zeroconf"

DEPEND="
	>=net-libs/libvncserver-0.9
	net-libs/openslp
	x11-libs/libXdamage
	zeroconf? ( || ( net-dns/avahi net-misc/mDNSResponder ) )"
RDEPEND="${DEPEND}"

pkg_setup() {
	if use zeroconf && has_version net-dns/avahi; then
		KDE4_BUILT_WITH_USE_CHECK="
			${KDE4_BUILT_WITH_USE_CHECK} net-dns/avahi mdnsresponder-compat"
	fi
	kde4-meta_pkg_setup
}

src_compile() {
	# krfb requires both slp and vnc to build
	mycmakeargs="${mycmakeargs}
		-DWITH_Xmms=OFF -DWITH_SLP=ON -DWITH_LibVNCServer=ON
		$(cmake-utils_use_with zeroconf DNSSD)"

	kde4-meta_src_compile
}
