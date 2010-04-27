# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-geosciences/qlandkartegt-garmindev/qlandkartegt-garmindev-0.3.3.ebuild,v 1.1 2010/04/27 10:28:18 scarabeus Exp $

EAPI="3"

MY_P=${P/qlandkartegt-/}

inherit cmake-utils

DESCRIPTION="Garmin drivers for qlandkartegt."
HOMEPAGE="http://www.qlandkarte.org/"
SRC_URI="mirror://sourceforge/qlandkartegt/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	dev-libs/libusb
	sci-geosciences/qlandkartegt
"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"
