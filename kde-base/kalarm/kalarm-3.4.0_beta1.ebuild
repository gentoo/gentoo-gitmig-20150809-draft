# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kalarm/kalarm-3.4.0_beta1.ebuild,v 1.1 2005/01/15 02:24:26 danarmak Exp $

KMNAME=kdepim
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="Personal alarm message, command and email scheduler for KDE"
KEYWORDS="~x86"
IUSE=""
OLDDEPEND="~kde-base/libkdepim-$PV
	~kde-base/libkdenetwork-$PV
	~kde-base/libkcal-$PV"
DEPEND="$(deprange-dual $PV $MAXKDEVER kde-base/libkdepim)
$(deprange-dual $PV $MAXKDEVER kde-base/libkdenetwork)
$(deprange-dual $PV $MAXKDEVER kde-base/libkmime)
$(deprange-dual $PV $MAXKDEVER kde-base/libkpimidentities)
$(deprange-dual $PV $MAXKDEVER kde-base/libkcal)"

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