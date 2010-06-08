# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/virtualbox-ose-additions/virtualbox-ose-additions-3.2.4.ebuild,v 1.2 2010/06/08 16:12:23 polynomial-c Exp $

EAPI=2

inherit eutils

MY_PN=VBoxGuestAdditions
MY_P=${MY_PN}-${PV}

DESCRIPTION="CD image containing guest additions for VirtualBox"
HOMEPAGE="http://www.virtualbox.org/"
SRC_URI="http://download.virtualbox.org/virtualbox/${PV}/${MY_P}.iso"

LICENSE="PUEL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror"
PROPERTIES="interactive"

RDEPEND="!app-emulation/virtualbox-bin
	!=app-emulation/virtualbox-ose-9999"

pkg_setup() {
	# We cannot mirror VirtualBox PUEL licensed files see:
	# http://www.virtualbox.org/wiki/Licensing_FAQ
	check_license
}

src_unpack() {
	return 0
}

src_install() {
	insinto /usr/share/${PN/-additions}
	newins "${DISTDIR}"/${MY_P}.iso ${MY_PN}.iso
}
