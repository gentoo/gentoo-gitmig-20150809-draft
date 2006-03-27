# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeedu-meta/kdeedu-meta-3.4.3.ebuild,v 1.12 2006/03/27 13:48:03 agriffis Exp $
MAXKDEVER=$PV

inherit kde-functions
DESCRIPTION="kdeedu - merge this to pull in all kdeedu-derived packages"
HOMEPAGE="http://www.kde.org/"

LICENSE="GPL-2"
SLOT="3.4"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86"
IUSE=""

RDEPEND="
$(deprange $PV $MAXKDEVER kde-base/kig)
$(deprange $PV $MAXKDEVER kde-base/kalzium)
$(deprange $PV $MAXKDEVER kde-base/khangman)
$(deprange 3.4.2 $MAXKDEVER kde-base/kpercentage)
$(deprange $PV $MAXKDEVER kde-base/kiten)
$(deprange $PV $MAXKDEVER kde-base/kvoctrain)
$(deprange 3.4.2 $MAXKDEVER kde-base/kturtle)
$(deprange 3.4.2 $MAXKDEVER kde-base/kverbos)
$(deprange 3.4.2 $MAXKDEVER kde-base/kdeedu-applnk)
$(deprange 3.4.2 $MAXKDEVER kde-base/kbruch)
$(deprange 3.4.2 $MAXKDEVER kde-base/keduca)
$(deprange 3.4.2 $MAXKDEVER kde-base/kmessedwords)
$(deprange $PV $MAXKDEVER kde-base/klatin)
$(deprange $PV $MAXKDEVER kde-base/kmplot)
$(deprange $PV $MAXKDEVER kde-base/kstars)
$(deprange $PV $MAXKDEVER kde-base/ktouch)
$(deprange 3.4.2 $MAXKDEVER kde-base/klettres)
$(deprange $PV $MAXKDEVER kde-base/kwordquiz)
"

# Not compiled by default.
#$(deprange 3.4.2 $MAXKDEVER kde-base/kmathtool)
