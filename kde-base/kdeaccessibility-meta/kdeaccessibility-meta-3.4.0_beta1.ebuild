# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeaccessibility-meta/kdeaccessibility-meta-3.4.0_beta1.ebuild,v 1.1 2005/01/15 02:24:29 danarmak Exp $
MAXKDEVER=$PV

inherit kde-functions
DESCRIPTION="kdeaccessibility - merge this to pull in all kdeaccessiblity-derived packages"
HOMEPAGE="http://www.kde.org/"

LICENSE="GPL-2"
SLOT="3.4"
KEYWORDS="~x86"
IUSE=""

RDEPEND="
$(deprange $PV $MAXKDEVER kde-base/kmag)
$(deprange $PV $MAXKDEVER kde-base/kmousetool)
$(deprange $PV $MAXKDEVER kde-base/kmouth)"

