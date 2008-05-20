# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-geosciences/qlandkarte/qlandkarte-0.7.2.ebuild,v 1.1 2008/05/20 14:04:44 hanno Exp $

DESCRIPTION="View and upload map files, track and waypoint data to your Garmin GPS."
HOMEPAGE="http://qlandkarte.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/QLandkarte-${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND=">=x11-libs/qt-4.2.1
	sci-libs/proj
	dev-libs/libusb"

S="${WORKDIR}/QLandkarte-${PV}"
MAKEOPTS="${MAKEOPTS} -j1"

src_compile() {
	econf || die "configure failed"
	emake || die "make failed"
}

src_install() {
	emake INSTALL_ROOT="${D}" install || die "install failed"
}
