# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdenetwork-meta/kdenetwork-meta-4.0.4.ebuild,v 1.1 2008/05/15 23:21:44 ingmar Exp $

EAPI="1"

inherit kde4-functions

DESCRIPTION="kdenetwork - merge this to pull in all kdenetwork-derived packages"
HOMEPAGE="http://www.kde.org/"

LICENSE="GPL-2"
SLOT="kde-4"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	>=kde-base/kdenetwork-filesharing-${PV}:${SLOT}
	>=kde-base/kdnssd-${PV}:${SLOT}
	>=kde-base/kget-${PV}:${SLOT}
	>=kde-base/knewsticker-${PV}:${SLOT}
	>=kde-base/kopete-${PV}:${SLOT}
	>=kde-base/kppp-${PV}:${SLOT}
	>=kde-base/krdc-${PV}:${SLOT}
	>=kde-base/krfb-${PV}:${SLOT}"
#	>=kde-base/lisa-${PV}:${SLOT}
