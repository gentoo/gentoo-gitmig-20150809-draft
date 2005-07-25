# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/bplay/bplay-0.991.ebuild,v 1.16 2005/07/25 12:07:33 dholm Exp $

IUSE=""

DESCRIPTION="No-frills command-line buffered player and recorder."
HOMEPAGE="http://www.amberdata.demon.co.uk/bplay/"
SRC_URI="http://www.amberdata.demon.co.uk/bplay/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 hppa ~ppc sparc x86"

DEPEND="virtual/libc"

src_compile() {
	emake CFLAGS="${CFLAGS} -Wall -DUSEBUFFLOCK" bplay || die
}

src_install () {
	dobin bplay || die
	dosym /usr/bin/bplay /usr/bin/brec
	doman bplay.1 brec.1
	dodoc README
}
