# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/akregator/akregator-3.5.2.ebuild,v 1.3 2006/05/25 21:25:21 wolf31o2 Exp $

KMNAME=kdepim
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE news feed aggregator"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc x86"
IUSE=""
DEPEND="$(deprange $PV $MAXKDEVER kde-base/libkdepim)
$(deprange $PV $MAXKDEVER kde-base/kontact)
!net-www/akregator"

KMCOPYLIB="libkdepim libkdepim
libkpinterfaces kontact/interfaces"
KMEXTRACTONLY="libkdepim
kontact/interfaces"
KMEXTRA="kontact/plugins/akregator"

