# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/bplay/bplay-0.991.ebuild,v 1.2 2002/07/11 06:30:40 drobbins Exp $

DESCRIPTION="No-frills command-line buffered player and recorder."
HOMEPAGE="http://www.amberdata.demon.co.uk/bplay/"

SRC_URI="http://www.amberdata.demon.co.uk/bplay/${P}.tar.gz"
S="${WORKDIR}/${P}"

DEPEND="virtual/glibc"

src_compile() {
    emake CFLAGS="${CFLAGS} -Wall -DUSEBUFFLOCK" bplay || die
}

src_install () {
    exeinto /usr/bin
    doexe bplay
    dosym /usr/bin/bplay /usr/bin/brec
    doman bplay.1 brec.1
    dodoc COPYING README
}
