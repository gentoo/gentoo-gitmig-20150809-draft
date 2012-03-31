# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/cd-discid/cd-discid-0.9.ebuild,v 1.8 2012/03/31 17:46:21 armin76 Exp $

IUSE=""

inherit toolchain-funcs

DESCRIPTION="returns the disc id for the cd in the cd-rom drive"
SRC_URI="http://lly.org/~rcw/cd-discid/${PN}_${PV}.orig.tar.gz"
HOMEPAGE="http://lly.org/~rcw/abcde/page/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha amd64 ppc ppc64 x86"

src_compile() {
	echo $(tc-getCC) ${CFLAGS} ${LDFLAGS} -o cd-discid cd-discid.c
	$(tc-getCC) ${CFLAGS} ${LDFLAGS} -o cd-discid cd-discid.c \
		|| die "compile failed"
}

src_install () {
	into /usr
	dobin cd-discid
	doman cd-discid.1

	dodoc README changelog
}
