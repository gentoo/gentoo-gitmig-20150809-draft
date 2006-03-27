# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdenetwork-meta/kdenetwork-meta-3.4.3.ebuild,v 1.8 2006/03/27 14:23:48 agriffis Exp $
MAXKDEVER=$PV

inherit kde-functions
DESCRIPTION="kdenetwork - merge this to pull in all kdenetwork-derived packages"
HOMEPAGE="http://www.kde.org/"

LICENSE="GPL-2"
SLOT="3.4"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86"
IUSE="wifi"

RDEPEND="$(deprange $PV $MAXKDEVER kde-base/dcoprss)
	$(deprange 3.4.2 $MAXKDEVER kde-base/kdenetwork-filesharing)
	$(deprange 3.4.2 $MAXKDEVER kde-base/kdict)
	$(deprange $PV $MAXKDEVER kde-base/kget)
	$(deprange $PV $MAXKDEVER kde-base/knewsticker)
	$(deprange $PV $MAXKDEVER kde-base/kopete)
	$(deprange 3.4.2 $MAXKDEVER kde-base/kpf)
	$(deprange $PV $MAXKDEVER kde-base/kppp)
	$(deprange $PV $MAXKDEVER kde-base/krdc)
	$(deprange $PV $MAXKDEVER kde-base/krfb)
	$(deprange $PV $MAXKDEVER kde-base/ksirc)
	$(deprange 3.4.2 $MAXKDEVER kde-base/ktalkd)
	wifi? ( $(deprange $PV $MAXKDEVER kde-base/kwifimanager) )
	$(deprange 3.4.1 $MAXKDEVER kde-base/librss)
	$(deprange 3.4.2 $MAXKDEVER kde-base/kdnssd)
	$(deprange 3.4.2 $MAXKDEVER kde-base/kdenetwork-kfile-plugins)
	$(deprange $PV $MAXKDEVER kde-base/lisa)"
