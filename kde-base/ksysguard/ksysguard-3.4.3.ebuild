# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/ksysguard/ksysguard-3.4.3.ebuild,v 1.8 2006/03/27 15:37:54 agriffis Exp $

KMNAME=kdebase
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE System Guard"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86"
IUSE="lm_sensors"
DEPEND="lm_sensors? ( sys-apps/lm_sensors )"

PATCHES="${FILESDIR}/kdebase-3.4.1-configure.patch"

src_compile() {
	myconf="$myconf `use_with lm_sensors sensors`"
	kde-meta_src_compile
}
