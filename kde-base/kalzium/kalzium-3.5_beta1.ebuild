# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kalzium/kalzium-3.5_beta1.ebuild,v 1.2 2005/09/23 18:08:33 cryos Exp $
KMNAME=kdeedu
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="KDE: periodic table of the elements"
KEYWORDS="~amd64"
IUSE=""
OLDDEPEND="~kde-base/libkdeedu-3.3.1"
DEPEND="
$(deprange $PV $MAXKDEVER kde-base/libkdeedu)"

KMEXTRACTONLY="libkdeedu/kdeeduplot
	libkdeedu/kdeeduui"
KMCOPYLIB="libkdeeduplot libkdeedu/kdeeduplot
	libkdeeduui libkdeedu/kdeeduui"
