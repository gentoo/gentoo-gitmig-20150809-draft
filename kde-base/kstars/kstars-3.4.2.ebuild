# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kstars/kstars-3.4.2.ebuild,v 1.2 2005/08/08 22:06:55 kloeri Exp $
KMNAME=kdeedu
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="KDE Desktop Planetarium"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""
DEPEND="$(deprange $PV $MAXKDEVER kde-base/libkdeedu)"
OLDDEPEND="~kde-base/libkdeedu-$PV"

KMEXTRACTONLY="libkdeedu/extdate libkdeedu/kdeeduplot"
KMCOPYLIB="libextdate libkdeedu/extdate
	    libkdeeduplot libkdeedu/kdeeduplot"

src_unpack () {
	kde-meta_src_unpack
	cd $S
}
