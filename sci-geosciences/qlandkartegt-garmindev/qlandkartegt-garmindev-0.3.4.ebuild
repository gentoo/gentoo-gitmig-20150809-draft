# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-geosciences/qlandkartegt-garmindev/qlandkartegt-garmindev-0.3.4.ebuild,v 1.1 2011/06/01 11:34:33 scarabeus Exp $

EAPI=4

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
	virtual/libusb
	sci-geosciences/qlandkartegt
"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"
