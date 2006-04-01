# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/ksysguard/ksysguard-3.5.2.ebuild,v 1.3 2006/04/01 17:25:09 flameeyes Exp $

KMNAME=kdebase
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE System Guard"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="lm_sensors zeroconf"
DEPEND="lm_sensors? ( sys-apps/lm_sensors )
	zeroconf? ( net-misc/mDNSResponder )"

src_compile() {
	local myconf="$(use_with lm_sensors sensors)
	              $(use_enable zeroconf dnssd)"

	kde-meta_src_compile
}
