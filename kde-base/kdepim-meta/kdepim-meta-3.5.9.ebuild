# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdepim-meta/kdepim-meta-3.5.9.ebuild,v 1.6 2008/05/14 15:52:05 corsair Exp $

EAPI="1"
inherit kde-functions
DESCRIPTION="kdepim - merge this to pull in all kdepim-derived packages"
HOMEPAGE="http://www.kde.org/"

LICENSE="GPL-2"
SLOT="3.5"
KEYWORDS="alpha ~amd64 hppa ia64 ppc ppc64 sparc ~x86 ~x86-fbsd"
IUSE="pda"

RDEPEND="
	>=kde-base/akregator-${PV}:${SLOT}
	>=kde-base/certmanager-${PV}:${SLOT}
	>=kde-base/kaddressbook-${PV}:${SLOT}
	>=kde-base/kalarm-${PV}:${SLOT}
	>=kde-base/kandy-${PV}:${SLOT}
	>=kde-base/karm-${PV}:${SLOT}
	>=kde-base/kdepim-kioslaves-${PV}:${SLOT}
	>=kde-base/kdepim-kresources-${PV}:${SLOT}
	>=kde-base/kdepim-wizards-${PV}:${SLOT}
	>=kde-base/kitchensync-${PV}:${SLOT}
	>=kde-base/kmail-${PV}:${SLOT}
	>=kde-base/kmailcvt-${PV}:${SLOT}
	>=kde-base/knode-${PV}:${SLOT}
	>=kde-base/knotes-${PV}:${SLOT}
	>=kde-base/kode-${PV}:${SLOT}
	>=kde-base/konsolekalendar-${PV}:${SLOT}
	>=kde-base/kontact-${PV}:${SLOT}
	>=kde-base/kontact-specialdates-${PV}:${SLOT}
	>=kde-base/korganizer-${PV}:${SLOT}
	>=kde-base/korn-${PV}:${SLOT}
	pda? ( >=kde-base/kpilot-${PV}:${SLOT} )
	>=kde-base/ktnef-${PV}:${SLOT}
	>=kde-base/libkcal-${PV}:${SLOT}
	>=kde-base/libkdenetwork-${PV}:${SLOT}
	>=kde-base/libkdepim-${PV}:${SLOT}
	>=kde-base/libkholidays-${PV}:${SLOT}
	>=kde-base/libkmime-${PV}:${SLOT}
	>=kde-base/libkpgp-${PV}:${SLOT}
	>=kde-base/libkpimexchange-${PV}:${SLOT}
	>=kde-base/libkpimidentities-${PV}:${SLOT}
	>=kde-base/libksieve-${PV}:${SLOT}
	>=kde-base/mimelib-${PV}:${SLOT}
	>=kde-base/networkstatus-${PV}:${SLOT}"
