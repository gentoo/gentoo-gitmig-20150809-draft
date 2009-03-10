# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-geosciences/qlandkartegt-garmindev/qlandkartegt-garmindev-0.1.0.ebuild,v 1.1 2009/03/10 17:37:37 hanno Exp $

inherit cmake-utils

DESCRIPTION="Garmin drivers for qlandkartegt."
HOMEPAGE="http://www.qlandkarte.org/"
SRC_URI="mirror://sourceforge/qlandkartegt/GarminDev.${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND="sci-geosciences/qlandkartegt
	dev-libs/libusb"
RDEPEND="${DEPEND}"
S="${WORKDIR}/GarminDev.2009.03.09"
