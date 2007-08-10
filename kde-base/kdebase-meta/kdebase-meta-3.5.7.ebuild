# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdebase-meta/kdebase-meta-3.5.7.ebuild,v 1.6 2007/08/10 16:18:11 angelos Exp $
MAXKDEVER=$PV

inherit kde-functions
DESCRIPTION="kdebase - merge this to pull in all kdebase-derived packages"
HOMEPAGE="http://www.kde.org/"

LICENSE="GPL-2"
SLOT="3.5"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND="
$(deprange $PV $MAXKDEVER kde-base/kdebase-startkde)
$(deprange $PV $MAXKDEVER kde-base/drkonqi)
$(deprange $PV $MAXKDEVER kde-base/kappfinder)
$(deprange $PV $MAXKDEVER kde-base/kate)
$(deprange 3.5.6 $MAXKDEVER kde-base/kcheckpass)
$(deprange 3.5.6 $MAXKDEVER kde-base/kcminit)
$(deprange $PV $MAXKDEVER kde-base/kcontrol)
$(deprange $PV $MAXKDEVER kde-base/kdcop)
$(deprange 3.5.6 $MAXKDEVER kde-base/kdebugdialog)
$(deprange $PV $MAXKDEVER kde-base/kdepasswd)
$(deprange $PV $MAXKDEVER kde-base/kdeprint)
$(deprange $PV $MAXKDEVER kde-base/kdesktop)
$(deprange $PV $MAXKDEVER kde-base/kdesu)
$(deprange 3.5.5 $MAXKDEVER kde-base/kdialog)
$(deprange $PV $MAXKDEVER kde-base/kdm)
$(deprange $PV $MAXKDEVER kde-base/kfind)
$(deprange $PV $MAXKDEVER kde-base/khelpcenter)
$(deprange $PV $MAXKDEVER kde-base/khotkeys)
$(deprange $PV $MAXKDEVER kde-base/kicker)
$(deprange $PV $MAXKDEVER kde-base/kdebase-kioslaves)
$(deprange $PV $MAXKDEVER kde-base/klipper)
$(deprange $PV $MAXKDEVER kde-base/kmenuedit)
$(deprange $PV $MAXKDEVER kde-base/konqueror)
$(deprange $PV $MAXKDEVER kde-base/konsole)
$(deprange $PV $MAXKDEVER kde-base/kpager)
$(deprange $PV $MAXKDEVER kde-base/kpersonalizer)
$(deprange 3.5.6 $MAXKDEVER kde-base/kreadconfig)
$(deprange $PV $MAXKDEVER kde-base/kscreensaver)
$(deprange $PV $MAXKDEVER kde-base/ksmserver)
$(deprange $PV $MAXKDEVER kde-base/ksplashml)
$(deprange 3.5.6 $MAXKDEVER kde-base/kstart)
$(deprange $PV $MAXKDEVER kde-base/ksysguard)
$(deprange 3.5.5 $MAXKDEVER kde-base/ksystraycmd)
$(deprange $PV $MAXKDEVER kde-base/ktip)
$(deprange $PV $MAXKDEVER kde-base/kwin)
$(deprange $PV $MAXKDEVER kde-base/kxkb)
$(deprange $PV $MAXKDEVER kde-base/libkonq)
$(deprange $PV $MAXKDEVER kde-base/nsplugins)
$(deprange $PV $MAXKDEVER kde-base/knetattach)
$(deprange $PV $MAXKDEVER kde-base/kdebase-data)"
