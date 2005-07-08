# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeutils-meta/kdeutils-meta-3.4.1.ebuild,v 1.7 2005/07/08 04:54:25 weeve Exp $
MAXKDEVER=$PV

inherit kde-functions
DESCRIPTION="kdeutils - merge this to pull in all kdeutils-derived packages"
HOMEPAGE="http://www.kde.org/"

LICENSE="GPL-2"
SLOT="3.4"
KEYWORDS="amd64 ppc ppc64 sparc x86"
IUSE="crypt lirc"

RDEPEND="
	$(deprange $PV $MAXKDEVER kde-base/ark)
	$(deprange $PV $MAXKDEVER kde-base/kcalc)
	$(deprange $PV $MAXKDEVER kde-base/kcharselect)
	lirc? ( $(deprange $PV $MAXKDEVER kde-base/kdelirc) )
	$(deprange $PV $MAXKDEVER kde-base/kdf)
	$(deprange $PV $MAXKDEVER kde-base/kedit)
	$(deprange $PV $MAXKDEVER kde-base/kfloppy)
	crypt? ( $(deprange $PV $MAXKDEVER kde-base/kgpg) )
	$(deprange $PV $MAXKDEVER kde-base/khexedit)
	$(deprange $PV $MAXKDEVER kde-base/kjots)
	$(deprange $PV $MAXKDEVER kde-base/klaptopdaemon)
	$(deprange $PV $MAXKDEVER kde-base/kmilo)
	$(deprange $PV $MAXKDEVER kde-base/kregexpeditor)
	$(deprange $PV $MAXKDEVER kde-base/ksim)
	$(deprange $PV $MAXKDEVER kde-base/ktimer)
	$(deprange $PV $MAXKDEVER kde-base/kwalletmanager)"
