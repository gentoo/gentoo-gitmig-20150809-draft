# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeedu-meta/kdeedu-meta-3.5.7.ebuild,v 1.7 2007/08/11 16:25:36 armin76 Exp $
MAXKDEVER=$PV

inherit kde-functions
DESCRIPTION="kdeedu - merge this to pull in all kdeedu-derived packages"
HOMEPAGE="http://www.kde.org/"

LICENSE="GPL-2"
SLOT="3.5"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND="
$(deprange $PV $MAXKDEVER kde-base/blinken)
$(deprange $PV $MAXKDEVER kde-base/kanagram)
$(deprange $PV $MAXKDEVER kde-base/kalzium)
$(deprange $PV $MAXKDEVER kde-base/kgeography)
$(deprange $PV $MAXKDEVER kde-base/khangman)
$(deprange $PV $MAXKDEVER kde-base/kig)
$(deprange $PV $MAXKDEVER kde-base/kpercentage)
$(deprange $PV $MAXKDEVER kde-base/kiten)
$(deprange $PV $MAXKDEVER kde-base/kvoctrain)
$(deprange $PV $MAXKDEVER kde-base/kturtle)
$(deprange $PV $MAXKDEVER kde-base/kverbos)
$(deprange $PV $MAXKDEVER kde-base/kdeedu-applnk)
$(deprange $PV $MAXKDEVER kde-base/kbruch)
$(deprange $PV $MAXKDEVER kde-base/keduca)
$(deprange $PV $MAXKDEVER kde-base/klatin)
$(deprange $PV $MAXKDEVER kde-base/kmplot)
$(deprange $PV $MAXKDEVER kde-base/kstars)
$(deprange $PV $MAXKDEVER kde-base/ktouch)
$(deprange $PV $MAXKDEVER kde-base/klettres)
$(deprange $PV $MAXKDEVER kde-base/kwordquiz)
"
