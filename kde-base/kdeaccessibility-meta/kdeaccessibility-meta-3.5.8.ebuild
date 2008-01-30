# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeaccessibility-meta/kdeaccessibility-meta-3.5.8.ebuild,v 1.5 2008/01/30 17:25:09 ranger Exp $
MAXKDEVER=$PV

inherit kde-functions
DESCRIPTION="kdeaccessibility - merge this to pull in all kdeaccessiblity-derived packages"
HOMEPAGE="http://www.kde.org/"

LICENSE="GPL-2"
SLOT="3.5"
KEYWORDS="alpha amd64 ia64 ~ppc ppc64 sparc x86"
IUSE="arts"

RDEPEND="
arts? ( $(deprange $PV $MAXKDEVER kde-base/ksayit)
	$(deprange $PV $MAXKDEVER kde-base/kttsd) )
$(deprange $PV $MAXKDEVER kde-base/kmag)
$(deprange $PV $MAXKDEVER kde-base/kdeaccessibility-iconthemes)
$(deprange $PV $MAXKDEVER kde-base/kmousetool)
$(deprange $PV $MAXKDEVER kde-base/kbstateapplet)
$(deprange $PV $MAXKDEVER kde-base/kmouth)"
