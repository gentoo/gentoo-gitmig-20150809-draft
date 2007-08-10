# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/ksysguard/ksysguard-3.5.7.ebuild,v 1.7 2007/08/10 15:45:46 angelos Exp $

KMNAME=kdebase
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KSysguard is a network enabled task manager and system monitor application, with the additional functionality of top."
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc ~x86 ~x86-fbsd"
IUSE="kdehiddenvisibility lm_sensors"
DEPEND="lm_sensors? ( sys-apps/lm_sensors )"

RDEPEND="${DEPEND}"

src_compile() {
	local myconf="--enable-dnssd $(use_with lm_sensors sensors)"

	kde-meta_src_compile
}
