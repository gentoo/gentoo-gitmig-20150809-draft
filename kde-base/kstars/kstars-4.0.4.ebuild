# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kstars/kstars-4.0.4.ebuild,v 1.1 2008/05/16 00:24:54 ingmar Exp $

EAPI="1"

KMNAME=kdeedu
inherit kde4-meta

DESCRIPTION="KDE Desktop Planetarium"
KEYWORDS="~amd64 ~x86"
IUSE="debug fits htmlhandbook nova sbig usb"

DEPEND=">=kde-base/libkdeedu-${PV}:${SLOT}
		fits? ( sci-libs/cfitsio )
		nova? ( >=sci-libs/libnova-0.12.1 )
		sbig? ( sci-libs/indilib
			usb? ( dev-libs/libusb ) )"
RDEPEND="${DEPEND}"

src_compile() {
	epatch "${FILESDIR}/${PN}-4.0.0-destdir.patch"

	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with fits CFitsio)
		$(cmake-utils_use_with nova Nova)
		$(cmake-utils_use_with sbig SBIG)
		$(cmake-utils_use_with usb USB)"

	kde4-meta_src_compile

	# FIXME Unhandled arguments - added sbig but not sure about use descriptions or flag names...
	# WITH_SBIG - Switch which controls the detection of the proprietary and binary only SBIG CCD universal library. No ebuild for this package
	# are available at the moment.
	# ssh_tunnel ->  INDI Server binds locally. Remote clients may only connect
	# via SSH Tunneling.
}
