# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/cd-discid/cd-discid-0.9.ebuild,v 1.1 2004/09/15 20:16:39 eradicator Exp $

IUSE=""

DESCRIPTION="returns the disc id for the cd in the cd-rom drive"
SRC_URI="http://lly.org/~rcw/cd-discid/${PN}_${PV}.orig.tar.gz"
HOMEPAGE="http://lly.org/~rcw/abcde/page/"

DEPEND="virtual/libc"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc ~ppc ~amd64"

src_compile() {
	echo gcc ${CFLAGS} -o cd-discid cd-discid.c
	gcc ${CFLAGS} -o cd-discid cd-discid.c
}

src_install () {
	into /usr
	dobin cd-discid
	doman cd-discid.1

	dodoc README changelog
}
