# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-geosciences/qlandkartegt-garmindev/qlandkartegt-garmindev-0.2.0.ebuild,v 1.1 2009/05/07 14:45:11 hanno Exp $

inherit cmake-utils

DESCRIPTION="Garmin drivers for qlandkartegt."
HOMEPAGE="http://www.qlandkarte.org/"
SRC_URI="mirror://sourceforge/qlandkartegt/${P/qlandkartegt-/}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND="sci-geosciences/qlandkartegt
	dev-libs/libusb"
RDEPEND="${DEPEND}"
S="${WORKDIR}/${P/qlandkartegt-/}"
