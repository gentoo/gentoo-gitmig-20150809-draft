# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/ksysguard/ksysguard-3.5.9.ebuild,v 1.7 2008/05/18 18:03:13 maekke Exp $

KMNAME=kdebase
EAPI="1"
inherit kde-meta eutils

DESCRIPTION="KSysguard, a network enabled task manager/system monitor, with additional functionality of top."
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="kdehiddenvisibility lm_sensors"

DEPEND="lm_sensors? ( sys-apps/lm_sensors )"
RDEPEND="${DEPEND}"

src_compile() {
	local myconf="--enable-dnssd $(use_with lm_sensors sensors)"

	kde-meta_src_compile
}
