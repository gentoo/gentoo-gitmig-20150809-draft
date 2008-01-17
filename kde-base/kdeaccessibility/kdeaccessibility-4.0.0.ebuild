# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeaccessibility/kdeaccessibility-4.0.0.ebuild,v 1.1 2008/01/17 23:38:26 philantrop Exp $

EAPI="1"

inherit kde4-base

DESCRIPTION="KDE accessibility module"
HOMEPAGE="http://www.kde.org/"

KEYWORDS="~amd64 ~x86"
IUSE="debug htmlhandbook alsa ktts"
LICENSE="GPL-2 LGPL-2"

COMMONDEPEND="ktts? ( alsa? ( >=media-libs/alsa-lib-1.0.14a ) )
	|| ( >=kde-base/kdebase-${PV}:${SLOT}
		( >=kde-base/kcmshell-${PV}:${SLOT}
			>=kde-base/knotify-${PV}:${SLOT}
			>=kde-base/phonon-${PV}:${SLOT} ) )"

DEPEND="${DEPEND} ${COMMONDEPEND}"

RDEPEND="${RDEPEND} ${COMMONDEPEND}
	ktts? ( app-accessibility/festival
		app-accessibility/epos
		app-accessibility/freetts )
	app-accessibility/flite"

src_compile() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with alsa Alsa)
		-DKDE4_KTTSD_PHONON=$(use alsa && echo ON || echo OFF)
		-DKDE4_KTTSD_ALSA=$(use alsa && echo ON || echo OFF)
		$(cmake-utils_use_with ktts Kttsmodule)
		-DKDE4_KTTSD_EPOS=ON
		-DKDE4_KTTSD_FESTIVAL=ON
		-DKDE4_KTTSD_FLITE=ON
		-DKDE4_KTTSD_FREETTS=ON
		-DKDE4_KTTSD_HADIFIX=OFF"

	kde4-base_src_compile
}
