# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdenetwork-meta/kdenetwork-meta-3.5.2.ebuild,v 1.4 2006/05/01 15:52:36 flameeyes Exp $
MAXKDEVER=$PV

inherit kde-functions
DESCRIPTION="kdenetwork - merge this to pull in all kdenetwork-derived packages"
HOMEPAGE="http://www.kde.org/"

LICENSE="GPL-2"
SLOT="3.5"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="wifi"

RDEPEND="$(deprange $PV $MAXKDEVER kde-base/dcoprss)
	$(deprange $PV $MAXKDEVER kde-base/kdenetwork-filesharing)
	$(deprange $PV $MAXKDEVER kde-base/kdict)
	$(deprange $PV $MAXKDEVER kde-base/kget)
	$(deprange $PV $MAXKDEVER kde-base/knewsticker)
	|| ( $(deprange $PV $MAXKDEVER kde-base/kopete) net-im/kopete )
	$(deprange $PV $MAXKDEVER kde-base/kpf)
	$(deprange $PV $MAXKDEVER kde-base/kppp)
	$(deprange $PV $MAXKDEVER kde-base/krdc)
	$(deprange $PV $MAXKDEVER kde-base/krfb)
	$(deprange $PV $MAXKDEVER kde-base/ksirc)
	$(deprange $PV $MAXKDEVER kde-base/ktalkd)
	wifi? ( $(deprange $PV $MAXKDEVER kde-base/kwifimanager) )
	$(deprange 3.5.0 $MAXKDEVER kde-base/librss)
	$(deprange $PV $MAXKDEVER kde-base/kdnssd)
	$(deprange $PV $MAXKDEVER kde-base/kdenetwork-kfile-plugins)
	$(deprange $PV $MAXKDEVER kde-base/lisa)"
