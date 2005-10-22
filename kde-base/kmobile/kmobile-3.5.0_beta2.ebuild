# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kmobile/kmobile-3.5.0_beta2.ebuild,v 1.3 2005/10/22 07:10:34 halcy0n Exp $

KMNAME=kdepim
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE mobile devices manager"
KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND="app-mobilephone/gnokii
	$(deprange $PV $MAXKDEVER kde-base/libkcal)"

KMCOPYLIB="libkcal libkcal"

# bugs.kde.org #114522
PATCHES="$FILESDIR/$P-fix-compilation.diff"
