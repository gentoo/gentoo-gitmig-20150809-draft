# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/gtick/gtick-0.2.4.ebuild,v 1.4 2004/04/20 17:21:57 eradicator Exp $

IUSE=""

DESCRIPTION="a metronome application supporting different meters and speeds ranging"
HOMEPAGE="http://www.antcom.de/gtick/"
SRC_URI="http://savannah.nongnu.org/download/gtick/default.pkg/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND=">=x11-libs/gtk+-2.0
	virtual/glibc"

src_compile() {
	econf || die "configure failed"
	emake || die
}

src_install() {
	einstall || die
	dodoc AUTHORS COPYING REAME NEWS
}
