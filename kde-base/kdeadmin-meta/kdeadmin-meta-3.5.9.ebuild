# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeadmin-meta/kdeadmin-meta-3.5.9.ebuild,v 1.4 2008/05/12 20:03:11 ranger Exp $

EAPI="1"
inherit kde-functions
DESCRIPTION="kdeadmin - merge this to pull in all kdeadmin-derived packages"
HOMEPAGE="http://www.kde.org/"

LICENSE="GPL-2"
SLOT="3.5"
KEYWORDS="alpha ~amd64 ~hppa ia64 ppc ~ppc64 sparc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=kde-base/kcron-${PV}:${SLOT}
	>=kde-base/kdeadmin-kfile-plugins-${PV}:${SLOT}
	>=kde-base/kuser-${PV}:${SLOT}
	x86? ( >=kde-base/lilo-config-${PV}:${SLOT} )
	amd64? ( >=kde-base/lilo-config-${PV}:${SLOT} )
	>=kde-base/secpolicy-${PV}:${SLOT}
	>=kde-base/knetworkconf-${PV}:${SLOT}"

# NOTE: KPackage, KSysv are useless on a normal gentoo system and so aren't included
# in the above list. KDat is broken and unmaintained. However, packages do nominally
# exist for them.
