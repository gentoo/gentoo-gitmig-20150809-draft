# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeedu-meta/kdeedu-meta-3.5.9.ebuild,v 1.7 2008/05/18 21:15:39 maekke Exp $

EAPI="1"
inherit kde-functions
DESCRIPTION="kdeedu - merge this to pull in all kdeedu-derived packages"
HOMEPAGE="http://www.kde.org/"

LICENSE="GPL-2"
SLOT="3.5"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND="
>=kde-base/blinken-${PV}:${SLOT}
>=kde-base/kanagram-${PV}:${SLOT}
>=kde-base/kalzium-${PV}:${SLOT}
>=kde-base/kgeography-${PV}:${SLOT}
>=kde-base/khangman-${PV}:${SLOT}
>=kde-base/kig-${PV}:${SLOT}
>=kde-base/kpercentage-${PV}:${SLOT}
>=kde-base/kiten-${PV}:${SLOT}
>=kde-base/kvoctrain-${PV}:${SLOT}
>=kde-base/kturtle-${PV}:${SLOT}
>=kde-base/kverbos-${PV}:${SLOT}
>=kde-base/kdeedu-applnk-${PV}:${SLOT}
>=kde-base/kbruch-${PV}:${SLOT}
>=kde-base/keduca-${PV}:${SLOT}
>=kde-base/klatin-${PV}:${SLOT}
>=kde-base/kmplot-${PV}:${SLOT}
>=kde-base/kstars-${PV}:${SLOT}
>=kde-base/ktouch-${PV}:${SLOT}
>=kde-base/klettres-${PV}:${SLOT}
>=kde-base/kwordquiz-${PV}:${SLOT}
"
