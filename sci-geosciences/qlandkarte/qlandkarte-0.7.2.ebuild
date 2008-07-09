# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-geosciences/qlandkarte/qlandkarte-0.7.2.ebuild,v 1.2 2008/07/09 00:18:27 hanno Exp $

EAPI="1"

DESCRIPTION="View and upload map files, track and waypoint data to your Garmin GPS."
HOMEPAGE="http://qlandkarte.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/QLandkarte-${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND="|| ( ( x11-libs/qt-core:4 x11-libs/qt-gui:4 ) >=x11-libs/qt-4.2.1 )
	sci-libs/proj
	dev-libs/libusb"

S="${WORKDIR}/QLandkarte-${PV}"

src_install() {
	emake INSTALL_ROOT="${D}" install || die "install failed"
}
