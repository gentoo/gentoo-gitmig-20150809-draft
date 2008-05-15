# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdemultimedia-meta/kdemultimedia-meta-4.0.4.ebuild,v 1.1 2008/05/15 23:20:28 ingmar Exp $

EAPI="1"

inherit kde4-functions

DESCRIPTION="kdemultimedia - merge this to pull in all kdemultimedia-derived packages"
HOMEPAGE="http://www.kde.org/"

LICENSE="GPL-2"
SLOT="kde-4"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	>=kde-base/juk-${PV}:${SLOT}
	>=kde-base/kdemultimedia-kioslaves-${PV}:${SLOT}
	>=kde-base/kmix-${PV}:${SLOT}
	>=kde-base/kscd-${PV}:${SLOT}
	>=kde-base/libkcddb-${PV}:${SLOT}
	>=kde-base/libkcompactdisc-${PV}:${SLOT}
"
