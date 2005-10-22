# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/ksysguard/ksysguard-3.5.0_beta2.ebuild,v 1.2 2005/10/22 07:33:03 halcy0n Exp $

KMNAME=kdebase
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE System Guard"
KEYWORDS="~amd64 ~x86"
IUSE="lm_sensors zeroconf"
DEPEND="lm_sensors? ( sys-apps/lm_sensors )
	zeroconf? ( net-misc/mDNSResponder )"

src_compile() {
	local myconf="$(use_with lm_sensors sensors)
	              $(use_enable zeroconf dnssd)"

	kde-meta_src_compile
}
