# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kalzium/kalzium-3.5.0_rc1.ebuild,v 1.1 2005/11/12 15:49:23 danarmak Exp $
KMNAME=kdeedu
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="KDE: periodic table of the elements"
KEYWORDS="~amd64 ~x86"
IUSE=""
HOMEPAGE="http://edu.kde.org/kalzium"

DEPEND="$(deprange $PV $MAXKDEVER kde-base/libkdeedu)"

KMEXTRACTONLY="libkdeedu/kdeeduplot
	libkdeedu/kdeeduui"
KMCOPYLIB="libkdeeduplot libkdeedu/kdeeduplot
	libkdeeduui libkdeedu/kdeeduui"
