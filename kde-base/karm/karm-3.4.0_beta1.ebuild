# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/karm/karm-3.4.0_beta1.ebuild,v 1.1 2005/01/15 02:24:27 danarmak Exp $

KMNAME=kdepim
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE Time tracker tool"
KEYWORDS="~x86"
IUSE=""
OLDDEPEND="~kde-base/libkcal-$PV
	~kde-base/libkdepim-$PV"
DEPEND="$(deprange-dual $PV $MAXKDEVER kde-base/libkcal)
$(deprange-dual $PV $MAXKDEVER kde-base/kdepim-kresources)
$(deprange-dual $PV $MAXKDEVER kde-base/libkdepim)"

KMCOPYLIB="
	libkcal libkcal
	libkdepim libkdepim
	libkcal_resourceremote kresources/remote"
KMEXTRACTONLY="
	libkcal/
	libkdepim/
	kresources/remote"
