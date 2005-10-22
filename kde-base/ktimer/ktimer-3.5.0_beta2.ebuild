# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/ktimer/ktimer-3.5.0_beta2.ebuild,v 1.2 2005/10/22 07:34:48 halcy0n Exp $

KMNAME=kdeutils
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE Timer"
KEYWORDS="~amd64 ~x86"
IUSE=""