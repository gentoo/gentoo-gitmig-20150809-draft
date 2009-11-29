# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/klipper/klipper-4.3.3-r1.ebuild,v 1.2 2009/11/29 15:22:56 ssuominen Exp $

EAPI="2"

KMNAME="kdebase-workspace"
inherit kde4-meta

DESCRIPTION="Applet for KDE and X clipboard management"
KEYWORDS="~alpha amd64 ~hppa ~ia64 ~ppc ~ppc64 ~x86"
IUSE="debug +handbook"

SRC_URI="${SRC_URI}
	http://dev.gentooexperimental.org/~scarabeus/${SLOT}-${PN}_empty_actions.patch.bz2
"

DEPEND="
	$(add_kdebase_dep libkworkspace)
	$(add_kdebase_dep libtaskmanager)
	x11-libs/libXfixes
"
RDEPEND="${DEPEND}"

src_unpack() {
	kde4-meta_src_unpack
	unpack "${SLOT}-${PN}_empty_actions.patch.bz2"
}

src_prepare() {
	kde4-meta_src_prepare
	epatch "${WORKDIR}/${SLOT}-${PN}_empty_actions.patch"
}
