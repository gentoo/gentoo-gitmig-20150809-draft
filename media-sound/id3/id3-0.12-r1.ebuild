# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/id3/id3-0.12-r1.ebuild,v 1.10 2004/02/09 01:04:52 vapier Exp $

DESCRIPTION="changes the id3 tag in an mp3 file"
HOMEPAGE="http://lly.org/~rcw/abcde/page/"
SRC_URI="http://lly.org/~rcw/id3/${PN}_${PV}.orig.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"

src_compile() {
	make CFLAGS="${CFLAGS}" || die
}

src_install() {
	make install DESTDIR=${D} || die
	dodoc README
}
