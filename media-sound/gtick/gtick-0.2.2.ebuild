# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header:

DESCRIPTION="GTick is a metronome application supporting different meters and speeds ranging"
HOMEPAGE="http://www.antcom.de/gtick/"
SRC_URI="http://savannah.nongnu.org/download/gtick/default.pkg/${PV}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

RDEPEND=">=x11-libs/gtk+-2.0"
DEPEND="virtual/glibc
		${RDEPEND}"

S=${WORKDIR}/${P}

src_compile() {
	econf || die "configure failed"
	emake || die
}

src_install() {
	einstall || die
	dodoc AUTHORS COPYING REAME NEWS
}

