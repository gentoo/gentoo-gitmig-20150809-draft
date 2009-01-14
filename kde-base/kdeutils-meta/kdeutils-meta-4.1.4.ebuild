# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeutils-meta/kdeutils-meta-4.1.4.ebuild,v 1.2 2009/01/14 09:00:09 alexxy Exp $

EAPI="2"

inherit kde4-functions

DESCRIPTION="kdeutils - merge this to pull in all kdeutils-derived packages"
HOMEPAGE="http://www.kde.org/"

LICENSE="GPL-2"
SLOT="4.1"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="floppy"

RDEPEND="
	>=kde-base/ark-${PV}:${SLOT}
	>=kde-base/kcalc-${PV}:${SLOT}
	>=kde-base/kcharselect-${PV}:${SLOT}
	>=kde-base/kdessh-${PV}:${SLOT}
	>=kde-base/kdf-${PV}:${SLOT}
	floppy? ( >=kde-base/kfloppy-${PV}:${SLOT} )
	>=kde-base/kgpg-${PV}:${SLOT}
	>=kde-base/kjots-${PV}:${SLOT}
	>=kde-base/ktimer-${PV}:${SLOT}
	>=kde-base/kwallet-${PV}:${SLOT}
	>=kde-base/superkaramba-${PV}:${SLOT}
	>=kde-base/sweeper-${PV}:${SLOT}
	>=kde-base/okteta-${PV}:${SLOT}
	"
