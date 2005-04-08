# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/cd-discid/cd-discid-0.9.ebuild,v 1.5 2005/04/08 17:29:54 hansmi Exp $

IUSE=""

inherit toolchain-funcs

DESCRIPTION="returns the disc id for the cd in the cd-rom drive"
SRC_URI="http://lly.org/~rcw/cd-discid/${PN}_${PV}.orig.tar.gz"
HOMEPAGE="http://lly.org/~rcw/abcde/page/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ppc ppc64 sparc x86"

DEPEND="virtual/libc"

src_compile() {
	echo $(tc-getCC) ${CFLAGS} -o cd-discid cd-discid.c
	$(tc-getCC) ${CFLAGS} -o cd-discid cd-discid.c
}

src_install () {
	into /usr
	dobin cd-discid
	doman cd-discid.1

	dodoc README changelog
}
