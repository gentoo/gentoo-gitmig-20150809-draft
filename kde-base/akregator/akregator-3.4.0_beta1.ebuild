# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/akregator/akregator-3.4.0_beta1.ebuild,v 1.1 2005/01/15 02:24:25 danarmak Exp $

KMNAME=kdepim
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="KDE news feed aggregator"
KEYWORDS="~x86"
IUSE=""
RDEPEND="!net-www/akregator"

KMCOPYLIB="libkdepim libkdepim"
KMEXTRACTONLY="libkdepim"
