# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/virtualbox-ose-additions/virtualbox-ose-additions-2.0.6.ebuild,v 1.1 2008/12/18 12:45:25 flameeyes Exp $

inherit eutils

MY_PN=VBoxGuestAdditions
MY_P=${MY_PN}_${PV}

DESCRIPTION="Guest additions for VirtualBox"
HOMEPAGE="http://www.virtualbox.org/"
SRC_URI="${MY_P}.iso"

LICENSE="PUEL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="!app-emulation/virtualbox-bin
	!=app-emulation/virtualbox-ose-9999"

RESTRICT="fetch"

pkg_nofetch() {
	# Fetch restriction added due licensing and problems downloading with
	# wget, see http://www.virtualbox.org/ticket/2148
	elog "Please download the package from:"
	elog ""
	elog "http://download.virtualbox.org/virtualbox/${PV}/${MY_P}.iso"
	elog ""
	elog "and then put it in ${DISTDIR}"
}

src_unpack() {
	return 0
}

src_install() {
	insinto /usr/share/${PN/-additions}
	newins "${DISTDIR}"/${MY_P}.iso ${MY_PN}.iso
}
