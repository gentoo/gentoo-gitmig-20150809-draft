# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kitchensync/kitchensync-3.4.0_beta1.ebuild,v 1.1 2005/01/15 02:24:33 danarmak Exp $

KMNAME=kdepim
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="Synchronize Data with KDE"
KEYWORDS="~x86"
IUSE=""
OLDDEPEND="~kde-base/libkdepim-$PV
	~kde-base/libkcal-$PV"
DEPEND="$(deprange-dual $PV $MAXKDEVER kde-base/libkdepim)
$(deprange-dual $PV $MAXKDEVER kde-base/libkcal)"
RDEPEND="$DEPEND
	!app-pda/kitchensync"

KMCOPYLIB="
	libkcal libkcal
	libkdepim libkdepim"
KMEXTRACTONLY="
	libkcal/
	libkdepim/
	libkdenetwork/"
