# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdesdk-meta/kdesdk-meta-3.4.0_rc1.ebuild,v 1.1 2005/02/27 20:21:34 danarmak Exp $
MAXKDEVER=$PV

inherit kde-functions
DESCRIPTION="kdesdk - merge this to pull in all kdesdk-derived packages"
HOMEPAGE="http://www.kde.org/"

LICENSE="GPL-2"
SLOT="3.4"
KEYWORDS="~x86"
IUSE=""

RDEPEND="
	$(deprange $PV $MAXKDEVER kde-base/cervisia)
	$(deprange 3.4.0_beta2 $MAXKDEVER kde-base/kapptemplate)
	$(deprange $PV $MAXKDEVER kde-base/kbabel)
	$(deprange $PV $MAXKDEVER kde-base/kbugbuster)
	$(deprange $PV $MAXKDEVER kde-base/kcachegrind)
	$(deprange $PV $MAXKDEVER kde-base/kdesdk-kfile-plugins)
	$(deprange 3.4.0_beta2 $MAXKDEVER kde-base/kdesdk-misc)
	$(deprange $PV $MAXKDEVER kde-base/kdesdk-scripts)
	$(deprange 3.4.0_beta2 $MAXKDEVER kde-base/kmtrace)
	$(deprange $PV $MAXKDEVER kde-base/kompare)
	$(deprange 3.4.0_beta2 $MAXKDEVER kde-base/kspy)
	$(deprange 3.4.0_beta2 $MAXKDEVER kde-base/kuiviewer)
	$(deprange $PV $MAXKDEVER kde-base/kdesdk-kioslaves)
	$(deprange $PV $MAXKDEVER kde-base/umbrello)"
