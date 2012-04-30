# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-geosciences/qlandkarte/qlandkarte-0.7.4.ebuild,v 1.4 2012/04/30 07:16:08 jlec Exp $

EAPI=4

inherit autotools eutils qt4-r2

DESCRIPTION="View and upload map files, track and waypoint data to your Garmin GPS"
HOMEPAGE="http://qlandkarte.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/QLandkarte_final.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	dev-libs/libusb
	sci-libs/proj
	x11-libs/qt-core:4
	x11-libs/qt-gui:4"
RDEPEND="${DEPEND}"

S="${WORKDIR}/QLandkarte_final"

src_prepare() {
	eautoreconf
}

src_configure() {
	default
	qt4-r2_src_configure
}
