# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kstars/kstars-3.5.0_rc1.ebuild,v 1.1 2005/11/12 15:49:33 danarmak Exp $
KMNAME=kdeedu
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="KDE Desktop Planetarium"
KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND="$(deprange $PV $MAXKDEVER kde-base/libkdeedu)"


KMEXTRACTONLY="libkdeedu/extdate
	libkdeedu/kdeeduplot
	libkdeedu/kdeeduui"
KMCOPYLIB="libextdate libkdeedu/extdate
	    libkdeeduplot libkdeedu/kdeeduplot
		libkdeeduui libkdeedu/kdeeduui"

src_unpack () {
	kde-meta_src_unpack
	cd $S
}
