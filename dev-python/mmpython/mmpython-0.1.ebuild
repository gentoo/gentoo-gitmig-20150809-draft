# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2

DESCRIPTION="Media metadata retrieval framework for Python."
HOMEPAGE="http://sourceforge.net/projects/mmpython/"
SRC_URI="mirror://sourceforge/${PN}/${PN}_${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc"

DEPEND=">=media-libs/libdvdread-0.9.3"

S="${WORKDIR}/${PN}_${PV}"

inherit distutils

src_unpack() {
	unpack ${A} && cd "${S}"
	epatch "${FILESDIR}/less-debug.patch"
}
