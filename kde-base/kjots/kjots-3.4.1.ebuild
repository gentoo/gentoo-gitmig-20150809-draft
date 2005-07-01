# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kjots/kjots-3.4.1.ebuild,v 1.4 2005/07/01 14:51:50 corsair Exp $

KMNAME=kdeutils
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="Kjots - KDE note taking utility"
KEYWORDS="amd64 ~ppc ppc64 ~sparc x86"
IUSE=""