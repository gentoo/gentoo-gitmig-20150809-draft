# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/ksync/ksync-3.5_alpha1.ebuild,v 1.1 2005/09/07 12:57:42 flameeyes Exp $

KMNAME=kdepim
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE pda synchronizer"
KEYWORDS="~amd64"
IUSE=""
DEPEND="$(deprange $PV $MAXKDEVER kde-base/libkcal)"
OLDDEPEND="~kde-base/libkcal-$PV"

KMCOPYLIB="
	libkcal libkcal"
KMEXTRACTONLY="
	libkcal/"
