# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/krdc/krdc-4.0.4.ebuild,v 1.1 2008/05/16 00:13:54 ingmar Exp $

EAPI="1"

KMNAME=kdenetwork
inherit kde4-meta

DESCRIPTION="KDE remote desktop connection (RDP and VNC) client"
KEYWORDS="~amd64 ~x86"
IUSE="debug htmlhandbook jpeg vnc zeroconf"

DEPEND="
	jpeg? ( media-libs/jpeg )
	vnc? ( >=net-libs/libvncserver-0.9 )
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
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with jpeg JPEG)
		$(cmake-utils_use_with vnc LibVNCServer)
		$(cmake-utils_use_with zeroconf DNSSD)"
	kde4-meta_src_compile
}

pkg_postinst() {
	kde4-meta_pkg_postinst

	echo
	elog "If you want to use the remote desktop protocol (RDP) install >=net-misc/rdesktop-1.4.1"
	echo
}
