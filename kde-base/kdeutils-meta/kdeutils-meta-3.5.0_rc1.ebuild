# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeutils-meta/kdeutils-meta-3.5.0_rc1.ebuild,v 1.1 2005/11/12 15:49:28 danarmak Exp $
MAXKDEVER=$PV

inherit kde-functions
DESCRIPTION="kdeutils - merge this to pull in all kdeutils-derived packages"
HOMEPAGE="http://www.kde.org/"

LICENSE="GPL-2"
SLOT="3.5"
KEYWORDS="~amd64 ~x86"
IUSE="crypt lirc"

RDEPEND="
	$(deprange 3.5.0_beta2 $MAXKDEVER kde-base/ark)
	$(deprange $PV $MAXKDEVER kde-base/kcalc)
	$(deprange 3.5_beta1 $MAXKDEVER kde-base/kcharselect)
	lirc? ( $(deprange $PV $MAXKDEVER kde-base/kdelirc) )
	$(deprange $PV $MAXKDEVER kde-base/kdf)
	$(deprange 3.5.0_beta2 $MAXKDEVER kde-base/kedit)
	$(deprange $PV $MAXKDEVER kde-base/kfloppy)
	crypt? ( $(deprange $PV $MAXKDEVER kde-base/kgpg) )
	$(deprange $PV $MAXKDEVER kde-base/khexedit)
	$(deprange 3.5_beta1 $MAXKDEVER kde-base/kjots)
	$(deprange $PV $MAXKDEVER kde-base/klaptopdaemon)
	$(deprange $PV $MAXKDEVER kde-base/kmilo)
	$(deprange $PV $MAXKDEVER kde-base/kregexpeditor)
	$(deprange $PV $MAXKDEVER kde-base/ksim)
	$(deprange $PV $MAXKDEVER kde-base/ktimer)
	$(deprange 3.5_beta1 $MAXKDEVER kde-base/kwalletmanager)
	$(deprange $PV $MAXKDEVER kde-base/superkaramba)"
