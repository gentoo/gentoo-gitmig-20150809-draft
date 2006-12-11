# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/ksysguard/ksysguard-3.5.5.ebuild,v 1.9 2006/12/11 12:00:41 kloeri Exp $

KMNAME=kdebase
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

SRC_URI="${SRC_URI}
	mirror://gentoo/kdebase-3.5-patchset-03.tar.bz2"

DESCRIPTION="KSysguard is a network enabled task manager and system monitor application, with the additional functionality of top."
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="kdehiddenvisibility lm_sensors zeroconf"
DEPEND="lm_sensors? ( sys-apps/lm_sensors )
	zeroconf? ( net-misc/mDNSResponder )"

RDEPEND="${DEPEND}"

src_compile() {
	local myconf="$(use_with lm_sensors sensors)
	              $(use_enable zeroconf dnssd)"

	kde-meta_src_compile
}

