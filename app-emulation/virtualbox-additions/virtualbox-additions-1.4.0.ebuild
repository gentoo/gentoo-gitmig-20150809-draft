# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header $

inherit eutils

MY_PN=VBoxGuestAdditions
MY_P=${MY_PN}_${PV}

DESCRIPTION="Guest additions for VirtualBox"
HOMEPAGE="http://www.virtualbox.org/"
SRC_URI="http://virtualbox.org/download/${PV}/${MY_P}.iso"

LICENSE="PUEL"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

RDEPEND="!app-emulation/virtualbox-bin"

RESTRICT="primaryuri"

pkg_setup() {
	check_license
}

src_unpack() {
	return 0
}

src_install() {
	insinto /opt/VirtualBox/additions
	newins "${DISTDIR}"/${MY_P}.iso ${MY_PN}.iso
}
