# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/akregator/akregator-3.4.0.ebuild,v 1.1 2005/03/13 21:18:58 danarmak Exp $

KMNAME=kdepim
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="KDE news feed aggregator"
KEYWORDS="~x86 ~amd64"
IUSE=""
DEPEND="$(deprange $PV $MAXKDEVER kde-base/libkdepim)
$(deprange $PV $MAXKDEVER kde-base/kontact)
!net-www/akregator"

KMCOPYLIB="libkdepim libkdepim
libkpinterfaces kontact/interfaces"
KMEXTRACTONLY="libkdepim
kontact/interfaces"
KMEXTRA="kontact/plugins/akregator"
