# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kalarm/kalarm-3.5.0_rc1.ebuild,v 1.1 2005/11/12 15:49:23 danarmak Exp $

KMNAME=kdepim
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="Personal alarm message, command and email scheduler for KDE"
KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND="$(deprange $PV $MAXKDEVER kde-base/libkdepim)
$(deprange 3.5_beta1 $MAXKDEVER kde-base/libkdenetwork)
$(deprange 3.5_beta1 $MAXKDEVER kde-base/libkmime)
$(deprange $PV $MAXKDEVER kde-base/libkpimidentities)
$(deprange $PV $MAXKDEVER kde-base/libkcal)"

KMCOPYLIB="
	libkcal libkcal
	libkdepim libkdepim
	libkmime libkmime
	libkpimidentities libkpimidentities"
KMEXTRACTONLY="
	libkcal/libical
	libkdepim/
	libkdenetwork/
	libkpimidentities/
	libkmime/"
KMCOMPILEONLY="
	libkcal/libical/src/libical/
	libkcal/libical/src/libicalss/"

src_compile() {
	export DO_NOT_COMPILE="libkcal" && kde-meta_src_compile myconf configure
	# generate "ical.h"
	cd ${S}/libkcal/libical/src/libical && make ical.h
	# generate "icalss.h"
	cd ${S}/libkcal/libical/src/libicalss && make icalss.h

	kde-meta_src_compile make
}