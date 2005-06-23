# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/hwdata-knoppix/hwdata-knoppix-0.107-r1.ebuild,v 1.7 2005/06/23 13:52:50 wolf31o2 Exp $

inherit eutils

MY_PV=${PV}-8
DESCRIPTION="Data for the hwsetup program"
SRC_URI="http://developer.linuxtag.net/knoppix/sources/${PN}_${MY_PV}.tar.gz"
HOMEPAGE="http://www.knopper.net"

IUSE="opengl livecd"
KEYWORDS="alpha amd64 ppc ppc64 ~sparc x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND=""
RDEPEND=""

src_unpack() {
	unpack ${A}
	if use x86 || use amd64; then
		if use livecd && use opengl; then
			epatch ${FILESDIR}/${P}-binary_drivers.patch || die "patching"
		fi
	fi
}

src_install() {
	dodoc debian/README.build debian/changelog debian/control debian/copyright debian/mergepcitable
	insinto /usr/share/hwdata
	doins debian/pcitable-knoppix CardMonitorCombos Cards MonitorsDB pci.ids pcitable upgradelist usb.ids
}
