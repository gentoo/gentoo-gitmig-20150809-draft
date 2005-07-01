# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeaccessibility-meta/kdeaccessibility-meta-3.4.1.ebuild,v 1.4 2005/07/01 09:15:36 corsair Exp $
MAXKDEVER=$PV

inherit kde-functions
DESCRIPTION="kdeaccessibility - merge this to pull in all kdeaccessiblity-derived packages"
HOMEPAGE="http://www.kde.org/"

LICENSE="GPL-2"
SLOT="3.4"
KEYWORDS="amd64 ~ppc ppc64 ~sparc x86"
IUSE="arts"

RDEPEND="
arts? ( $(deprange $PV $MAXKDEVER kde-base/ksayit)
	$(deprange $PV $MAXKDEVER kde-base/kttsd) )
$(deprange $PV $MAXKDEVER kde-base/kmag)
$(deprange $PV $MAXKDEVER kde-base/kdeaccessibility-iconthemes)
$(deprange $PV $MAXKDEVER kde-base/kmousetool)
$(deprange $PV $MAXKDEVER kde-base/kbstateapplet)
$(deprange $PV $MAXKDEVER kde-base/kmouth)"
