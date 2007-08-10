# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeaccessibility-meta/kdeaccessibility-meta-3.5.7.ebuild,v 1.6 2007/08/10 13:52:34 angelos Exp $
MAXKDEVER=$PV

inherit kde-functions
DESCRIPTION="kdeaccessibility - merge this to pull in all kdeaccessiblity-derived packages"
HOMEPAGE="http://www.kde.org/"

LICENSE="GPL-2"
SLOT="3.5"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc ~x86"
IUSE="arts"

RDEPEND="
arts? ( $(deprange $PV $MAXKDEVER kde-base/ksayit)
	$(deprange $PV $MAXKDEVER kde-base/kttsd) )
$(deprange $PV $MAXKDEVER kde-base/kmag)
$(deprange $PV $MAXKDEVER kde-base/kdeaccessibility-iconthemes)
$(deprange $PV $MAXKDEVER kde-base/kmousetool)
$(deprange $PV $MAXKDEVER kde-base/kbstateapplet)
$(deprange $PV $MAXKDEVER kde-base/kmouth)"
