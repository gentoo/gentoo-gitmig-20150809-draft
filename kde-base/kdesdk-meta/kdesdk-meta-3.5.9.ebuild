# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdesdk-meta/kdesdk-meta-3.5.9.ebuild,v 1.4 2008/05/18 20:51:23 maekke Exp $

EAPI="1"
inherit kde-functions
DESCRIPTION="kdesdk - merge this to pull in all kdesdk-derived packages"
HOMEPAGE="http://www.kde.org/"

LICENSE="GPL-2"
SLOT="3.5"
KEYWORDS="~alpha amd64 ~hppa ~ppc ppc64 ~sparc x86 ~x86-fbsd"
IUSE="subversion elibc_glibc"

RDEPEND="
	>=kde-base/cervisia-${PV}:${SLOT}
	>=kde-base/kapptemplate-${PV}:${SLOT}
	>=kde-base/kbabel-${PV}:${SLOT}
	>=kde-base/kbugbuster-${PV}:${SLOT}
	>=kde-base/kcachegrind-${PV}:${SLOT}
	>=kde-base/kdesdk-kfile-plugins-${PV}:${SLOT}
	>=kde-base/kdesdk-misc-${PV}:${SLOT}
	>=kde-base/kdesdk-scripts-${PV}:${SLOT}
	elibc_glibc? ( >=kde-base/kmtrace-${PV}:${SLOT} )
	>=kde-base/kompare-${PV}:${SLOT}
	>=kde-base/kspy-${PV}:${SLOT}
	>=kde-base/kuiviewer-${PV}:${SLOT}
	subversion? ( >=kde-base/kdesdk-kioslaves-${PV}:${SLOT} )
	>=kde-base/umbrello-${PV}:${SLOT}"
