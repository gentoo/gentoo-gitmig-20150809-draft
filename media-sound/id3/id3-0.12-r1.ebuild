# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/id3/id3-0.12-r1.ebuild,v 1.17 2006/05/23 19:53:58 corsair Exp $

IUSE=""

DESCRIPTION="changes the id3 tag in an mp3 file"
HOMEPAGE="http://lly.org/~rcw/abcde/page/"
SRC_URI="http://lly.org/~rcw/id3/${PN}_${PV}.orig.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 sparc x86"

src_compile() {
	make CFLAGS="${CFLAGS}" || die
}

src_install() {
	make install DESTDIR=${D} || die
	dodoc README
}
