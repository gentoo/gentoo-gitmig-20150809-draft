# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdnssd/kdnssd-4.0.5.ebuild,v 1.1 2008/06/05 21:42:38 keytoaster Exp $

EAPI="1"

KMNAME=kdenetwork
inherit kde4-meta

DESCRIPTION="A DNSSD (DNS Service Discovery - part of Rendezvous) ioslave and kded module"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="|| ( net-dns/avahi net-misc/mDNSResponder )"
RDEPEND="${DEPEND}"

pkg_setup() {
	if has_version net-dns/avahi; then
		KDE4_BUILT_WITH_USE_CHECK=("net-dns/avahi mdnsresponder-compat")
	fi
	kde4-meta_pkg_setup
}

src_compile() {
	mycmakeargs="${mycmakeargs} -DWITH_Xmms=OFF -DWITH_DNSSD=ON"

	kde4-meta_src_compile
}
