# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdepim-meta/kdepim-meta-3.4.0.ebuild,v 1.5 2005/03/26 01:17:36 weeve Exp $
MAXKDEVER=$PV

inherit kde-functions
DESCRIPTION="kdepim 3.3.0 - merge this to pull in all kdepim-derived packages"
HOMEPAGE="http://www.kde.org/"

LICENSE="GPL-2"
SLOT="3.4"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc"
IUSE=""

RDEPEND="
	$(deprange $PV $MAXKDEVER kde-base/certmanager)
	$(deprange $PV $MAXKDEVER kde-base/kaddressbook)
	$(deprange $PV $MAXKDEVER kde-base/kalarm)
	$(deprange $PV $MAXKDEVER kde-base/kandy)
	$(deprange $PV $MAXKDEVER kde-base/karm)
	$(deprange $PV $MAXKDEVER kde-base/kdepim-kioslaves)
	$(deprange $PV $MAXKDEVER kde-base/kdepim-kresources)
	$(deprange $PV $MAXKDEVER kde-base/kdepim-wizards)
	$(deprange $PV $MAXKDEVER kde-base/kitchensync)
	$(deprange $PV $MAXKDEVER kde-base/kmail)
	$(deprange $PV $MAXKDEVER kde-base/kmailcvt)
	$(deprange $PV $MAXKDEVER kde-base/kmobile)
	$(deprange $PV $MAXKDEVER kde-base/knode)
	$(deprange $PV $MAXKDEVER kde-base/knotes)
	$(deprange $PV $MAXKDEVER kde-base/kode)
	$(deprange $PV $MAXKDEVER kde-base/konsolekalendar)
	$(deprange $PV $MAXKDEVER kde-base/kontact)
	$(deprange $PV $MAXKDEVER kde-base/kontact-specialdates)
	$(deprange $PV $MAXKDEVER kde-base/korganizer)
	$(deprange $PV $MAXKDEVER kde-base/korn)
	$(deprange $PV $MAXKDEVER kde-base/kpilot)
	$(deprange $PV $MAXKDEVER kde-base/ksync)
	$(deprange $PV $MAXKDEVER kde-base/ktnef)
	$(deprange $PV $MAXKDEVER kde-base/libkcal)
	$(deprange $PV $MAXKDEVER kde-base/libkdenetwork)
	$(deprange $PV $MAXKDEVER kde-base/libkdepim)
	$(deprange $PV $MAXKDEVER kde-base/libkholidays)
	$(deprange $PV $MAXKDEVER kde-base/libkmime)
	$(deprange $PV $MAXKDEVER kde-base/libkpgp)
	$(deprange $PV $MAXKDEVER kde-base/libkpimexchange)
	$(deprange $PV $MAXKDEVER kde-base/libkpimidentities)
	$(deprange $PV $MAXKDEVER kde-base/libksieve)
	$(deprange $PV $MAXKDEVER kde-base/mimelib)
	$(deprange $PV $MAXKDEVER kde-base/networkstatus)"
