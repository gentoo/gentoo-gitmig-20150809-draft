# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kstars/kstars-3.4.3.ebuild,v 1.8 2006/03/24 22:53:05 agriffis Exp $
KMNAME=kdeedu
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="KDE Desktop Planetarium"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86"
IUSE=""
DEPEND="$(deprange 3.4.2 $MAXKDEVER kde-base/libkdeedu)"
OLDDEPEND="~kde-base/libkdeedu-$PV"

KMEXTRACTONLY="libkdeedu/extdate libkdeedu/kdeeduplot"
KMCOPYLIB="libextdate libkdeedu/extdate
	    libkdeeduplot libkdeedu/kdeeduplot"

src_unpack () {
	kde-meta_src_unpack
	cd $S
}
