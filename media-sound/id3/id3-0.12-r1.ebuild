# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/id3/id3-0.12-r1.ebuild,v 1.8 2003/01/19 03:34:27 kain Exp $

S=${WORKDIR}/${P}
DESCRIPTION="changes the id3 tag in an mp3 file"
SRC_URI="http://lly.org/~rcw/id3/${PN}_${PV}.orig.tar.gz"
HOMEPAGE="http://lly.org/~rcw/abcde/page/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"

src_compile() {

	make CFLAGS="${CFLAGS}" || die
}

src_install () {

	make \
		DESTDIR=${D} \
		INSTALL="/bin/install -c" \
		install || die

	dodoc COPYING README

}
