# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/noatun-oblique/noatun-oblique-3.4.0_beta1.ebuild,v 1.1 2005/01/15 02:24:41 danarmak Exp $
KMNAME=kdeaddons
KMNOMODULE=true
KMEXTRA="noatun-plugins/oblique"
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="Noatun auto-collatig playlist"
KEYWORDS="~x86"
IUSE=""
DEPEND="$(deprange-dual $PV $MAXKDEVER kde-base/noatun)
		=sys-libs/db-4.2*"
OLDDEPEND="~kde-base/noatun-$PV =sys-libs/db-4.2*"

myconf="--with-extra-includes=/usr/include/db4.2"
PATCHES="$FILESDIR/noatun-oblique-db-location.diff"
