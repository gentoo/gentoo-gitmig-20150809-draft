# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/akregator/akregator-3.4.0_beta1.ebuild,v 1.2 2005/01/15 20:14:35 danarmak Exp $

KMNAME=kdepim
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="KDE news feed aggregator"
KEYWORDS="~x86"
IUSE=""
DEPEND="$(deprange-dual $PV $MAXKDEVER kde-base/libkdepim)
!net-www/akregator"

KMCOPYLIB="libkdepim libkdepim"
KMEXTRACTONLY="libkdepim"
